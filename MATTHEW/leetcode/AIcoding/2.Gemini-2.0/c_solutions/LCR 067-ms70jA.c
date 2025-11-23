#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findMaximumXOR(int* nums, int numsSize) {
    int maxXor = 0;
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            int xor = nums[i] ^ nums[j];
            if (xor > maxXor) {
                maxXor = xor;
            }
        }
    }
    return maxXor;
}