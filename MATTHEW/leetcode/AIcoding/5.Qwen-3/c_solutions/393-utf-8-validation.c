#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool validUTF8(int* data, int dataSize) {
    int bytesLeft = 0;
    for (int i = 0; i < dataSize; i++) {
        if (bytesLeft == 0) {
            if ((data[i] & 0x80) == 0) {
                bytesLeft = 0;
            } else if ((data[i] & 0xE0) == 0xC0) {
                bytesLeft = 1;
            } else if ((data[i] & 0xF0) == 0xD0) {
                bytesLeft = 2;
            } else if ((data[i] & 0xF8) == 0xE0) {
                bytesLeft = 3;
            } else {
                return false;
            }
        } else {
            if ((data[i] & 0xC0) != 0x80) {
                return false;
            }
            bytesLeft--;
        }
    }
    return bytesLeft == 0;
}