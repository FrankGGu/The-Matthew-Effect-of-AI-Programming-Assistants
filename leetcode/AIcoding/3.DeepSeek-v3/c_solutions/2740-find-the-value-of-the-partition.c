#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int findValueOfPartition(int* nums, int numsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    int min_diff = INT_MAX;
    for (int i = 1; i < numsSize; i++) {
        int diff = nums[i] - nums[i - 1];
        if (diff < min_diff) {
            min_diff = diff;
        }
    }

    return min_diff;
}