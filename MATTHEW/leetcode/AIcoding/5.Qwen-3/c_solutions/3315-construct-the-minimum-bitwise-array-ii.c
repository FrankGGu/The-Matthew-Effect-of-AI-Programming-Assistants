#include <stdio.h>
#include <stdlib.h>

int* minBitwiseArray(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    for (int i = 0; i < numsSize; i++) {
        int minVal = nums[i];
        for (int j = 0; j < 31; j++) {
            if ((nums[i] & (1 << j)) == 0) {
                int candidate = nums[i] | (1 << j);
                if (candidate < minVal) {
                    minVal = candidate;
                }
            }
        }
        result[i] = minVal;
    }

    return result;
}