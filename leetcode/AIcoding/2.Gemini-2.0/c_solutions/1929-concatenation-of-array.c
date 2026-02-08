#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* getConcatenation(int* nums, int numsSize, int* returnSize){
    *returnSize = 2 * numsSize;
    int* result = (int*)malloc(sizeof(int) * (*returnSize));
    for (int i = 0; i < numsSize; i++) {
        result[i] = nums[i];
        result[i + numsSize] = nums[i];
    }
    return result;
}