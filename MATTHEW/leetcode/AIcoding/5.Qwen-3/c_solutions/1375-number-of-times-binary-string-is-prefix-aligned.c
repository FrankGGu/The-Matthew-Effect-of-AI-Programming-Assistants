#include <stdio.h>
#include <stdlib.h>

int numTimesAllBlue(int* binary, int binarySize) {
    int count = 0;
    int max = 0;
    for (int i = 0; i < binarySize; i++) {
        if (binary[i] == 1) {
            max = (i + 1 > max) ? i + 1 : max;
        }
        if (max == i + 1) {
            count++;
        }
    }
    return count;
}