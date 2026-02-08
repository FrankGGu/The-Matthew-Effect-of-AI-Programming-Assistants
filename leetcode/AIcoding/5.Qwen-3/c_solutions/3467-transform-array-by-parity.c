#include <stdio.h>
#include <stdlib.h>

int* sortArrayByParity(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int evenIndex = 0;
    int oddIndex = numsSize - 1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            result[evenIndex++] = nums[i];
        } else {
            result[oddIndex--] = nums[i];
        }
    }

    *returnSize = numsSize;
    return result;
}