#include <stdlib.h> // For qsort
#include <limits.h> // For INT_MAX

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimumDifference(int* nums, int numsSize, int k) {
    if (k == 1) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compare);

    int minDiff = INT_MAX;

    for (int i = 0; i <= numsSize - k; i++) {
        int currentDiff = nums[i + k - 1] - nums[i];
        if (currentDiff < minDiff) {
            minDiff = currentDiff;
        }
    }

    return minDiff;
}