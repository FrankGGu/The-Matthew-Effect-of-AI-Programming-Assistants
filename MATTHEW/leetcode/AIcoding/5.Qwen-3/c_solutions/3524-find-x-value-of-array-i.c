#include <stdio.h>
#include <stdlib.h>

int* getXArray(int* nums, int numsSize, int x, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == x) {
            result[*returnSize] = i;
            (*returnSize)++;
        }
    }
    return result;
}