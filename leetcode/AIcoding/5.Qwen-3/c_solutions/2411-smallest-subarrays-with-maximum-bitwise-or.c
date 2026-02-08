#include <stdio.h>
#include <stdlib.h>

int* smallestSubarraysWithMaximumBitwiseOR(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        int max_or = nums[i];
        result[i] = 1;
        for (int j = i + 1; j < numsSize; j++) {
            max_or |= nums[j];
            result[i] = j - i + 1;
        }
    }
    return result;
}