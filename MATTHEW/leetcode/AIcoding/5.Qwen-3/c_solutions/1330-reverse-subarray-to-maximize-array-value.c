#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxArrayValue(int* nums, int numsSize) {
    int* sorted = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        sorted[i] = nums[i];
    }
    qsort(sorted, numsSize, sizeof(int), compare);

    int maxVal = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] == sorted[numsSize - 1]) {
            maxVal = nums[i];
            break;
        }
    }

    free(sorted);
    return maxVal;
}