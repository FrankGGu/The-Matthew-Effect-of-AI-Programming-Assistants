#include <stdio.h>
#include <stdlib.h>

int* getFinalArray(int* nums, int numsSize, int k, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        result[i] = nums[i];
    }
    for (int i = 0; i < k; i++) {
        int* newResult = (int*)malloc(numsSize * sizeof(int));
        for (int j = 0; j < numsSize; j++) {
            if (j % 2 == 0) {
                newResult[j] = result[j] * 2;
            } else {
                newResult[j] = result[j] * 3;
            }
        }
        free(result);
        result = newResult;
    }
    *returnSize = numsSize;
    return result;
}