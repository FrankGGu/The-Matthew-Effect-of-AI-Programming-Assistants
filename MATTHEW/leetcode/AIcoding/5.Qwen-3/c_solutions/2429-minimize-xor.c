#include <stdio.h>
#include <stdlib.h>

int minimizeXOR(int nums[], int numsSize, int x) {
    int result = 0;
    for (int i = 0; i < numsSize; i++) {
        int xor = nums[i] ^ x;
        if (xor < result || i == 0) {
            result = xor;
        }
    }
    return result;
}