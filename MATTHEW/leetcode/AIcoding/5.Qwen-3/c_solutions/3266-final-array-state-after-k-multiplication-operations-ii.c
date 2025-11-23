#include <stdio.h>
#include <stdlib.h>

int* getFinalArray(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = numsSize;
    int* result = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        result[i] = nums[i];
    }
    for (int op = 0; op < k; op++) {
        int* temp = (int*)malloc(numsSize * sizeof(int));
        for (int i = 0; i < numsSize; i++) {
            if (i % 2 == 0) {
                temp[i] = result[i] * 2;
            } else {
                temp[i] = result[i] * 3;
            }
        }
        free(result);
        result = temp;
    }
    return result;
}