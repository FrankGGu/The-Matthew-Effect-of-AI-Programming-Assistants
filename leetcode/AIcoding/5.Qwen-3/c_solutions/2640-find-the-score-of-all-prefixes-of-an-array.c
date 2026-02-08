#include <stdio.h>
#include <stdlib.h>

int* prefixScore(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int score = 0;
    for (int i = 0; i < numsSize; i++) {
        score += nums[i];
        result[i] = score;
    }
    *returnSize = numsSize;
    return result;
}