#include <stdlib.h> // Required for qsort

static int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minPairSum(int* nums, int numsSize) {
    // Sort the array in ascending order
    qsort(nums, numsSize, sizeof(int), compare);

    int maxPairSum = 0;

    // Pair the smallest element with the largest, the second smallest with the second largest, and so on.
    // The maximum of these sums will be the minimized maximum pair sum.
    for (int i = 0; i < numsSize / 2; i++) {
        int currentPairSum = nums[i] + nums[numsSize - 1 - i];
        if (currentPairSum > maxPairSum) {
            maxPairSum = currentPairSum;
        }
    }

    return maxPairSum;
}