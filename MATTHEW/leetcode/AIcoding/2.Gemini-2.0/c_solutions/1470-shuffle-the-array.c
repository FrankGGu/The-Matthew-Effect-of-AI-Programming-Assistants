#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* shuffle(int* nums, int numsSize, int n, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * numsSize);
    *returnSize = numsSize;

    for (int i = 0; i < n; i++) {
        result[2 * i] = nums[i];
        result[2 * i + 1] = nums[i + n];
    }

    return result;
}