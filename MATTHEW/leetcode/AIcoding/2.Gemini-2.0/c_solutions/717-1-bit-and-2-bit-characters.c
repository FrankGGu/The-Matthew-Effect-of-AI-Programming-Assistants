#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isOneBitCharacter(int* bits, int bitsSize) {
    int i = 0;
    while (i < bitsSize - 1) {
        if (bits[i] == 1) {
            i += 2;
        } else {
            i += 1;
        }
    }
    return i == bitsSize - 1;
}