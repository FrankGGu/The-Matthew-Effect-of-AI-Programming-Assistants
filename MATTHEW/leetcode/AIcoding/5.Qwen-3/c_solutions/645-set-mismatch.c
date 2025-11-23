#include <stdio.h>
#include <stdlib.h>

int* findErrorNums(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    *returnSize = 2;

    for (int i = 0; i < numsSize; i++) {
        int index = abs(nums[i]) - 1;
        if (nums[index] < 0) {
            result[0] = abs(nums[i]);
        } else {
            nums[index] *= -1;
        }
    }

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] > 0) {
            result[1] = i + 1;
        }
    }

    return result;
}