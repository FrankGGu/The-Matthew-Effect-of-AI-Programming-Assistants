#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minFinalArrayLength(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);
    int n = numsSize;
    int result = 0;
    for (int i = 0; i < n; i++) {
        if (i == 0 || nums[i] != nums[i - 1]) {
            result++;
        }
    }
    return result;
}