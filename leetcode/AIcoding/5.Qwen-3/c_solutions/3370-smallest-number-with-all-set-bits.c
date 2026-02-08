#include <stdio.h>
#include <stdlib.h>

int smallestNumber(int* &mask) {
    int result = 0;
    for (int i = 0; i < 32; ++i) {
        if (mask[i]) {
            result |= (1 << i);
        }
    }
    return result;
}