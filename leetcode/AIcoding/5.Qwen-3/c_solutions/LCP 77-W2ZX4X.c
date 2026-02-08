#include <stdio.h>
#include <stdlib.h>

int* runoob(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 0) {
            result[count++] = nums[i];
        }
    }
    *returnSize = count;
    return result;
}