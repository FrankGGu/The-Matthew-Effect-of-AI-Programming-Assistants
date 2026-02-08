#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int subsetXORSum(int* nums, int numsSize) {
    int sum = 0;
    for (int i = 0; i < (1 << numsSize); i++) {
        int xorSum = 0;
        for (int j = 0; j < numsSize; j++) {
            if ((i >> j) & 1) {
                xorSum ^= nums[j];
            }
        }
        sum += xorSum;
    }
    return sum;
}