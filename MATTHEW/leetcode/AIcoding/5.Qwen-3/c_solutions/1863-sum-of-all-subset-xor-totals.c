#include <stdio.h>
#include <stdlib.h>

int xorSum(int* nums, int numsSize) {
    int total = 0;
    for (int i = 0; i < (1 << numsSize); i++) {
        int xor = 0;
        for (int j = 0; j < numsSize; j++) {
            if (i & (1 << j)) {
                xor ^= nums[j];
            }
        }
        total += xor;
    }
    return total;
}