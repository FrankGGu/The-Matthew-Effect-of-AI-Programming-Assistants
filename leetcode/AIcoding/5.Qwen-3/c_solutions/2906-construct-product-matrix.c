#include <stdio.h>
#include <stdlib.h>

int* distinctNumbers(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int index = 0;

    for (int i = 0; i < numsSize; i++) {
        int count = 0;
        for (int j = 0; j < numsSize; j++) {
            if (nums[i] == nums[j]) {
                count++;
            }
        }
        if (count == 1) {
            result[index++] = nums[i];
        }
    }

    *returnSize = index;
    return result;
}