#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimizeArrayValue(int* nums, int numsSize) {
    int* prefix = (int*)malloc(numsSize * sizeof(int));
    prefix[0] = nums[0];
    for (int i = 1; i < numsSize; i++) {
        prefix[i] = prefix[i - 1] + nums[i];
    }

    int minMax = 0;
    for (int i = 0; i < numsSize; i++) {
        int avg = (prefix[i] + i) / (i + 1);
        if (avg > minMax) {
            minMax = avg;
        }
    }

    free(prefix);
    return minMax;
}