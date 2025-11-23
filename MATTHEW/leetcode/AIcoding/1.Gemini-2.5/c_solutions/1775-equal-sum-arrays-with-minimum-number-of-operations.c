#include <stdlib.h> // For abs, though not strictly needed with conditional swap
#include <string.h> // For memcpy if needed, but not used here

int minOperations(int* nums1, int nums1Size, int* nums2, int nums2Size) {
    // Check initial impossibility condition
    // If the minimum possible sum of one array is greater than the maximum possible sum of the other,
    // it's impossible to make them equal.
    // Minimum sum for an array of size N is N * 1. Maximum sum is N * 6.
    if (nums1Size > 6 * nums2Size || nums2Size > 6 * nums1Size) {
        return -1;
    }

    long long sum1 = 0;
    for (int i = 0; i < nums1Size; i++) {
        sum1 += nums1[i];
    }

    long long sum2 = 0;
    for (int i = 0; i < nums2Size; i++) {
        sum2 += nums2[i];
    }

    if (sum1 == sum2) {
        return 0;
    }

    // Ensure sum1 is always the larger sum.
    // This simplifies the logic for calculating gains later.
    if (sum1 < sum2) {
        // Swap sums
        long long tempSum = sum1;
        sum1 = sum2;
        sum2 = tempSum;

        // Swap array pointers and sizes
        int* tempNums = nums1;
        nums1 = nums2;
        nums2 = tempNums;

        int tempSize = nums1Size;
        nums1Size = nums2Size;
        nums2Size = tempSize;
    }

    // Now, sum1 >= sum2. We need to reduce sum1 and/or increase sum2.
    long long diff = sum1 - sum2;

    // `counts[k]` will store the number of elements that can contribute a gain of `k`.
    // A gain of `k` means reducing the absolute difference between sums by `k`.
    // Possible gains range from 1 to 5.
    // E.g., changing 6 to 1 (gain 5), or 1 to 6 (gain 5).
    int counts[6] = {0}; // Index 0 is unused, indices 1-5 store counts for gains 1-5.

    // Populate counts for elements in `nums1` (the array with the larger sum).
    // We want to reduce these elements to 1 to maximize sum reduction.
    // An element `x` changed to 1 provides a gain of `x - 1`.
    for (int i = 0; i < nums1Size; i++) {
        counts[nums1[i] - 1]++;
    }

    // Populate counts for elements in `nums2` (the array with the smaller sum).
    // We want to increase these elements to 6 to maximize sum increase.
    // An element `x` changed to 6 provides a gain of `6 - x`.
    for (int i = 0; i < nums2Size; i++) {
        counts[6 - nums2[i]]++;
    }

    int operations = 0;
    // Greedily apply changes that provide the largest gain first.
    // Iterate from the maximum possible gain (5) down to the minimum (1).
    for (int k = 5; k >= 1; k--) {
        while (diff > 0 && counts[k] > 0) {
            diff -= k;         // Reduce the difference by the current gain `k`
            counts[k]--;       // Use one element that provides this gain
            operations++;      // Increment operation count
        }
        if (diff <= 0) {
            break; // If the difference is zero or negative, we've reached the target.
        }
    }

    return operations;
}