#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minBitFlips(int start, int goal) {
    int xor_val = start ^ goal;
    int count = 0;
    while (xor_val > 0) {
        count += xor_val & 1;
        xor_val >>= 1;
    }
    return count;
}