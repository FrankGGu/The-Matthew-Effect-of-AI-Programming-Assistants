#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findValueOfPartition(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    int minDiff = INT_MAX;

    for (int i = 0; i < numsSize - 1; i++) {
        int diff = nums[i+1] - nums[i];
        if (diff < minDiff) {
            minDiff = diff;
        }
    }

    return minDiff;
}