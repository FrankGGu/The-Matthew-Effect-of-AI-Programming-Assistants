#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int minDifference(int* nums, int numsSize) {
    if (numsSize <= 4) return 0;

    qsort(nums, numsSize, sizeof(int), cmp);

    int min_diff = nums[numsSize - 1] - nums[0];

    for (int i = 0; i <= 3; i++) {
        int diff = nums[numsSize - 1 - (3 - i)] - nums[i];
        if (diff < min_diff) {
            min_diff = diff;
        }
    }

    return min_diff;
}