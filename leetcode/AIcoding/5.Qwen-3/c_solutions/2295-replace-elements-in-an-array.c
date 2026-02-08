#include <stdio.h>
#include <stdlib.h>

int* replaceElements(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int maxVal = -1;
    for (int i = numsSize - 1; i >= 0; i--) {
        int temp = nums[i];
        result[i] = maxVal;
        if (temp > maxVal) {
            maxVal = temp;
        }
    }
    *returnSize = numsSize;
    return result;
}