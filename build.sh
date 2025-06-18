#!/bin/bash
set -e

APP="brightness-slider"
VERSION="1.0"
ARCH="all"

rm -rf build
mkdir -p build/${APP}-${VERSION}/DEBIAN
mkdir -p build/${APP}-${VERSION}/usr/local/bin
mkdir -p build/${APP}-${VERSION}/usr/share/applications

cp brightness-slider build/${APP}-${VERSION}/usr/local/bin/
cp desktop/brightness-slider.desktop build/${APP}-${VERSION}/usr/share/applications/

cat <<EOF > build/${APP}-${VERSION}/DEBIAN/control
Package: $APP
Version: $VERSION
Section: utils
Priority: optional
Architecture: $ARCH
Depends: python3, python3-tk, x11-xserver-utils
Maintainer: Shishu <you@example.com>
Description: A simple Python GUI app to control screen brightness using xrandr
EOF

dpkg-deb --build build/${APP}-${VERSION}
mv build/${APP}-${VERSION}.deb ${APP}_${VERSION}_${ARCH}.deb
echo "Done -> ${APP}_${VERSION}_${ARCH}.deb"
