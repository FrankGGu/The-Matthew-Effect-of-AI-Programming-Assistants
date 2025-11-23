#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* findOccurrences(int* nums, int numsSize, int target, int* returnSize) {
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == target) {
            count++;
        }
    }

    if (count == 0) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(count * sizeof(int));
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int index = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == target) {
            result[index] = i;
            index++;
        }
    }

    *returnSize = count;
    return result;
}