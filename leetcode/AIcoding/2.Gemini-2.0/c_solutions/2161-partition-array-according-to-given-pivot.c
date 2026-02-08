#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* pivotArray(int* nums, int numsSize, int pivot, int* returnSize){
    int less_count = 0;
    int equal_count = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < pivot) {
            less_count++;
        } else if (nums[i] == pivot) {
            equal_count++;
        }
    }

    int* result = (int*)malloc(sizeof(int) * numsSize);
    *returnSize = numsSize;

    int less_index = 0;
    int equal_index = less_count;
    int greater_index = less_count + equal_count;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < pivot) {
            result[less_index++] = nums[i];
        } else if (nums[i] == pivot) {
            result[equal_index++] = nums[i];
        } else {
            result[greater_index++] = nums[i];
        }
    }

    return result;
}