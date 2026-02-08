#include <stdio.h>
#include <stdlib.h>

int* getConcatenation(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(2 * numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        result[i] = nums[i];
        result[i + numsSize] = nums[i];
    }
    *returnSize = 2 * numsSize;
    return result;
}