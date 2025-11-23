#include <stdio.h>
#include <stdlib.h>

int* nextGreaterElements(int* nums, int numsSize, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        result[i] = -1;
    }
    for (int i = 0; i < numsSize; i++) {
        for (int j = 1; j <= numsSize; j++) {
            int k = (i + j) % numsSize;
            if (nums[k] > nums[i]) {
                result[i] = nums[k];
                break;
            }
        }
    }
    return result;
}