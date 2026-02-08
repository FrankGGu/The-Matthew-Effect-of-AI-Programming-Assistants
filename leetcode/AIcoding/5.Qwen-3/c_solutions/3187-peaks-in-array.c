#include <stdio.h>
#include <stdlib.h>

int* peaksInArray(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int count = 0;

    for (int i = 1; i < numsSize - 1; i++) {
        if (nums[i] > nums[i - 1] && nums[i] > nums[i + 1]) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    return result;
}