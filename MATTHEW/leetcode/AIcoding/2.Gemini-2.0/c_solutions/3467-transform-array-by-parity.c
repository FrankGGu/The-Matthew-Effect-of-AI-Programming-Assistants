#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* sortArrayByParity(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;
    int evenIndex = 0;
    int oddIndex = numsSize - 1;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            result[evenIndex] = nums[i];
            evenIndex++;
        } else {
            result[oddIndex] = nums[i];
            oddIndex--;
        }
    }

    return result;
}