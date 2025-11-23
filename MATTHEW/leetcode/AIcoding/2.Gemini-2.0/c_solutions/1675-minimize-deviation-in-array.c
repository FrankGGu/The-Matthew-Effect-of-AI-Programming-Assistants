#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimumDeviation(int* nums, int numsSize) {
    int minVal = 1e9 + 7;
    int maxVal = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] % 2 == 1) {
            nums[i] *= 2;
        }
        if (nums[i] < minVal) {
            minVal = nums[i];
        }
        if (nums[i] > maxVal) {
            maxVal = nums[i];
        }
    }

    qsort(nums, numsSize, sizeof(int), cmp);

    int deviation = maxVal - minVal;
    while (nums[numsSize - 1] % 2 == 0) {
        nums[numsSize - 1] /= 2;
        if (nums[numsSize - 1] < minVal) {
            minVal = nums[numsSize - 1];
            qsort(nums, numsSize, sizeof(int), cmp);
        } else {
            maxVal = nums[numsSize - 1];
        }
        deviation = (maxVal - minVal) < deviation ? (maxVal - minVal) : deviation;
    }

    return deviation;
}