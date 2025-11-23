#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* adjacentIncreasingSubarrays(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = 0;
    int* result = (int*)malloc(numsSize * sizeof(int));
    if (result == NULL) return NULL;

    for (int i = 0; i < numsSize - k; i++) {
        bool increasing = true;
        for (int j = i; j < i + k; j++) {
            if (nums[j] >= nums[j + 1]) {
                increasing = false;
                break;
            }
        }
        if (increasing) {
            result[*returnSize] = i;
            (*returnSize)++;
        }
    }

    return result;
}