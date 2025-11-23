#include <stdio.h>
#include <stdlib.h>

int* separateSquares(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < numsSize; i++) {
        int square = nums[i] * nums[i];
        result[*returnSize] = square;
        (*returnSize)++;
    }

    return result;
}