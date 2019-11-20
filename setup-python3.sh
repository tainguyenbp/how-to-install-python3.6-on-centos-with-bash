#!/bin/bash

DIR_SOURCE=/usr/src
VERSION=3.6.6
URL_DOWNLOAD_FILE="https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz"
TARBALL="$DIR_SOURCE"/Python-${VERSION}.tgz

cd $DIR_SOURCE

function _setup_system_packages() {
    yum -y gcc openssl-devel zlib-devel bzip2-devel sqlite sqlite-devel
    yum groupinstall -y "Development Tools"
}

function _download_python3_source() {
    wget --no-check-certificate "$URL_DOWNLOAD_FILE" -O "$TARBALL"
}

function _extract_python3_source() {
    tar -C "$DIR_SOURCE" -xvf "$TARBALL"
}

function _compile_python3() {
    cd Python-${VERSION}
    ./configure --enable-optimizations
    make
    make altinstall
}

function _check_version_python3() {
    python3.6 -V
}

function _remove_python3() {
    cd Python-${VERSION}
    make clean
    make uninstall
    make -n install
}

_setup_system_packages
_download_python3_source
_extract_python3_source
_compile_python3
_check_version_python3
#_remove_python3