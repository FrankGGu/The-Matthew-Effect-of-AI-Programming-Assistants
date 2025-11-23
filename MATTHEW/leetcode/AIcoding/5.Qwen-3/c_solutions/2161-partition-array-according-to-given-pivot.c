#include <stdio.h>
#include <stdlib.h>

int* pivotArray(int* nums, int numsSize, int pivot, int* returnSize) {
    int* less = (int*)malloc(numsSize * sizeof(int));
    int* equal = (int*)malloc(numsSize * sizeof(int));
    int* greater = (int*)malloc(numsSize * sizeof(int));

    int l = 0, e = 0, g = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < pivot) {
            less[l++] = nums[i];
        } else if (nums[i] == pivot) {
            equal[e++] = nums[i];
        } else {
            greater[g++] = nums[i];
        }
    }

    int* result = (int*)malloc(numsSize * sizeof(int));
    int idx = 0;

    for (int i = 0; i < l; i++) {
        result[idx++] = less[i];
    }
    for (int i = 0; i < e; i++) {
        result[idx++] = equal[i];
    }
    for (int i = 0; i < g; i++) {
        result[idx++] = greater[i];
    }

    free(less);
    free(equal);
    free(greater);

    *returnSize = numsSize;
    return result;
}