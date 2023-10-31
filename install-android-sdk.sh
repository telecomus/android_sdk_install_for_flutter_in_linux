#!/bin/bash

## File: install-android-sdk.sh
## Copyright © 2022 Muzaffar Rayyan Auhammud
## License: MIT License (https://mit-license.org/)

ENV_FILE="~/.profile"
DISTRO=$(uname -r)
if [[ $DISTRO == *"MANJARO"* || $DISTRO == *"ARCH"* ]]
then
  ENV_FILE="/etc/profile"
fi
echo "" | sudo tee -a $ENV_FILE

ANDROID_HOME=$HOME/Android/Sdk

cd ~/Downloads && wget -c https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip
mkdir -p $ANDROID_HOME/cmdline-tools && unzip commandlinetools-linux-8512546_latest.zip -d $ANDROID_HOME/cmdline-tools
mv $ANDROID_HOME/cmdline-tools/cmdline-tools $ANDROID_HOME/cmdline-tools/latest

cd ~/Downloads && wget -c https://dl.google.com/android/repository/platform-tools-latest-linux.zip
mkdir -p $ANDROID_HOME && unzip platform-tools-latest-linux.zip -d $ANDROID_HOME

echo "export ANDROID_HOME=$ANDROID_HOME" | sudo tee -a $ENV_FILE
echo "export PATH=\$PATH:\$ANDROID_HOME/platform-tools" | sudo tee -a $ENV_FILE
echo "export PATH=\$PATH:\$ANDROID_HOME/cmdline-tools/latest/bin" | sudo tee -a $ENV_FILE
echo "export PATH=\$PATH:\$ANDROID_HOME/emulator" | sudo tee -a $ENV_FILE
source $ENV_FILE

# Android 10 Q Platform API and build tools
sdkmanager --install "platforms;android-31" "build-tools;30.0.3"

emulator -accel-check
