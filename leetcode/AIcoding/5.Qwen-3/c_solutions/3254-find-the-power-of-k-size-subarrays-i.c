#include <stdio.h>
#include <stdlib.h>

int* findSuccessors(int* nums, int numsSize, int k, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    for (int i = 0; i < numsSize; i++) {
        int maxVal = nums[i];
        for (int j = i + 1; j < i + k && j < numsSize; j++) {
            if (nums[j] > maxVal) {
                maxVal = nums[j];
            }
        }
        result[i] = maxVal;
    }

    return result;
}