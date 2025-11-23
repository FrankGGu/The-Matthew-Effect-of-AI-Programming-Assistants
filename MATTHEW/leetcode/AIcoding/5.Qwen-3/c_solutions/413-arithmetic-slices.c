#include <stdio.h>
#include <stdlib.h>

int* numberOfArithmeticSlices(int* nums, int numsSize, int* returnSize) {
    if (numsSize < 3) {
        *returnSize = 0;
        return NULL;
    }

    int* result = (int*)malloc(sizeof(int) * (numsSize - 2));
    int count = 0;

    for (int i = 0; i < numsSize - 2; i++) {
        int diff = nums[i + 1] - nums[i];
        if (nums[i + 2] - nums[i + 1] == diff) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    return result;
}