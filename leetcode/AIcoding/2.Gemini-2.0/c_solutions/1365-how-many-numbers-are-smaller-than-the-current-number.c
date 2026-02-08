#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* smallerNumbersThanCurrent(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = numsSize;

    for (int i = 0; i < numsSize; i++) {
        int count = 0;
        for (int j = 0; j < numsSize; j++) {
            if (i != j && nums[j] < nums[i]) {
                count++;
            }
        }
        result[i] = count;
    }

    return result;
}