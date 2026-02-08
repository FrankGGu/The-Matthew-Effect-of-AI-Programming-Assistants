#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool validUtf8(int* data, int dataSize) {
    int i = 0;
    while (i < dataSize) {
        int numBytes = 0;
        if ((data[i] & 0x80) == 0) {
            numBytes = 1;
        } else if ((data[i] & 0xE0) == 0xC0) {
            numBytes = 2;
        } else if ((data[i] & 0xF0) == 0xE0) {
            numBytes = 3;
        } else if ((data[i] & 0xF8) == 0xF0) {
            numBytes = 4;
        } else {
            return false;
        }

        if (i + numBytes > dataSize || numBytes == 1 && (data[i] & 0x80) != 0) return false;

        for (int j = 1; j < numBytes; j++) {
            if ((data[i + j] & 0xC0) != 0x80) {
                return false;
            }
        }

        if (numBytes > 4 || numBytes == 0) return false;

        i += numBytes;
    }
    return true;
}