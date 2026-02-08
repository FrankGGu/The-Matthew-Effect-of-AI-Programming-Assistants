#include <stdlib.h> // For malloc

int max(int a, int b) {
    return a > b ? a : b;
}

int calculateMaxSumForOrder(int* prefixSum, int numsSize, int L1, int L2) {
    int res = 0;
    // maxL1 tracks the maximum sum of a subarray of length L1
    // that ends at or before the current potential start of the L2 subarray.
    int maxL1 = 0; 

    // Iterate through all possible ending positions for the second subarray (L2).
    // The second subarray ends at index `i`. It starts at `i - L2 + 1`.
    // The first subarray (L1) must end at or before `i - L2`.
    // The loop starts at `L1 + L2 - 1` because this is the earliest index
    // where both subarrays can exist and be non-overlapping.
    // (L1 subarray ends at L1-1, L2 subarray ends at L1+L2-1)
    for (int i = L1 + L2 - 1; i < numsSize; i++) {
        // Calculate the sum of the L1 subarray that ends exactly at `i - L2`.
        // This subarray is nums[i - L2 - L1 + 1 ... i - L2].
        // Its sum using prefix sums is prefixSum[(i - L2) + 1] - prefixSum[(i - L2 - L1 + 1)].
        // Update maxL1 to be the maximum sum of an L1 subarray encountered so far
        // that ends at or before `i - L2`.
        maxL1 = max(maxL1, prefixSum[i - L2 + 1] - prefixSum[i - L2 - L1 + 1]);

        // Calculate the sum of the current L2 subarray ending at `i`.
        // This subarray is nums[i - L2 + 1 ... i].
        // Its sum using prefix sums is prefixSum[i + 1] - prefixSum[i + 1 - L2].
        int currentL2Sum = prefixSum[i + 1] - prefixSum[i + 1 - L2];

        // Update the overall maximum sum.
        res = max(res, maxL1 + currentL2Sum);
    }
    return res;
}

int maxSumTwoNoOverlap(int* nums, int numsSize, int firstLen, int secondLen) {
    // Calculate prefix sums for efficient subarray sum calculation.
    // prefixSum[k] stores the sum of nums[0]...nums[k-1].
    // So, sum of nums[i...j] = prefixSum[j+1] - prefixSum[i].
    int* prefixSum = (int*)malloc((numsSize + 1) * sizeof(int));
    prefixSum[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefixSum[i+1] = prefixSum[i] + nums[i];
    }

    int overallMax = 0;

    // Case 1: firstLen subarray appears before secondLen subarray
    overallMax = max(overallMax, calculateMaxSumForOrder(prefixSum, numsSize, firstLen, secondLen));

    // Case 2: secondLen subarray appears before firstLen subarray
    overallMax = max(overallMax, calculateMaxSumForOrder(prefixSum, numsSize, secondLen, firstLen));

    // Free allocated memory
    free(prefixSum);
    prefixSum = NULL;

    return overallMax;
}