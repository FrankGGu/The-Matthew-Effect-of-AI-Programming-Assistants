#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* targetIndices(int* nums, int numsSize, int target, int* returnSize) {
    int count = 0;
    int less = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == target) {
            count++;
        } else if (nums[i] < target) {
            less++;
        }
    }

    if (count == 0) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(sizeof(int) * count);
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    for (int i = 0; i < count; i++) {
        result[i] = less + i;
    }

    *returnSize = count;
    return result;
}