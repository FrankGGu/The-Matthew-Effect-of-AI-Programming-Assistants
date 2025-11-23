#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* sortArrayByParity(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;
    int start = 0;
    int end = numsSize - 1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            result[start++] = nums[i];
        } else {
            result[end--] = nums[i];
        }
    }

    return result;
}