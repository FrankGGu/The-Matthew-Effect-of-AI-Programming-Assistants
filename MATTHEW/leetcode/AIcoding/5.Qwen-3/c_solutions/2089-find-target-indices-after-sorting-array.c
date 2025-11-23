#include <stdio.h>
#include <stdlib.h>

int* targetIndices(int* nums, int numsSize, int target, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int count = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == target) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    return result;
}