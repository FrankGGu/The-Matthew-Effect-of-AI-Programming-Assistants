#include <stdlib.h> // Required for qsort

int compareInts(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long minOperationsToMakeMedianK(int* nums, int numsSize, int k) {
    // Sort the array to easily find the median and apply operations.
    qsort(nums, numsSize, sizeof(int), compareInts);

    // The median is at index numsSize / 2 (0-indexed) according to the problem definition.
    int medianIdx = numsSize / 2;
    long long operations = 0;

    // Phase 1: Adjust elements from the beginning up to and including the median index.
    // For the median to be K, all elements at or before the median index must be <= K.
    // If any nums[i] (where i <= medianIdx) is greater than K, we must decrease it to K.
    // The cost is nums[i] - K.
    for (int i = 0; i <= medianIdx; ++i) {
        if (nums[i] > k) {
            operations += (long long)(nums[i] - k);
        }
    }

    // Phase 2: Adjust elements from the median index to the end of the array.
    // For the median to be K, all elements at or after the median index must be >= K.
    // If any nums[i] (where i >= medianIdx) is less than K, we must increase it to K.
    // The cost is K - nums[i].
    //
    // Note: The median element (nums[medianIdx]) is covered by both loops.
    // - If nums[medianIdx] > K, its cost is added in the first loop.
    // - If nums[medianIdx] < K, its cost is added in the second loop.
    // - If nums[medianIdx] == K, it satisfies both conditions (not > K, not < K), so no cost is added for it in either loop, which is correct.
    // This combined approach correctly calculates abs(nums[medianIdx] - K) and also handles
    // the necessary adjustments for other elements to maintain the median property.
    for (int i = medianIdx; i < numsSize; ++i) {
        if (nums[i] < k) {
            operations += (long long)(k - nums[i]);
        }
    }

    return operations;
}