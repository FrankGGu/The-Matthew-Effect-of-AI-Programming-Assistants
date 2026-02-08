#include <limits.h> // Required for INT_MIN and INT_MAX

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int maxSubarraySumCircular(int* nums, int numsSize) {
    if (numsSize == 0) {
        return 0; // Should not happen based on constraints (1 <= numsSize)
    }

    int totalSum = 0;
    int maxSoFar = INT_MIN; // Current maximum sum ending at the current position
    int maxTotal = INT_MIN; // Overall maximum subarray sum (non-circular)
    int minSoFar = INT_MAX; // Current minimum sum ending at the current position
    int minTotal = INT_MAX; // Overall minimum subarray sum

    // Initialize with the first element
    maxSoFar = nums[0];
    maxTotal = nums[0];
    minSoFar = nums[0];
    minTotal = nums[0];
    totalSum = nums[0];

    // Iterate through the array starting from the second element
    for (int i = 1; i < numsSize; i++) {
        totalSum += nums[i];

        // Kadane's algorithm for maximum subarray sum
        maxSoFar = max(nums[i], maxSoFar + nums[i]);
        maxTotal = max(maxTotal, maxSoFar);

        // Kadane's algorithm for minimum subarray sum
        minSoFar = min(nums[i], minSoFar + nums[i]);
        minTotal = min(minTotal, minSoFar);
    }

    // Case 1: The maximum sum subarray is non-circular. This is 'maxTotal'.
    // Case 2: The maximum sum subarray is circular. This means the elements
    //         *not* included in the circular maximum sum subarray form a minimum
    //         sum subarray. So, the circular max sum is 'totalSum - minTotal'.

    // Edge case: If all numbers are negative (or zero), maxTotal will be the largest (least negative) number.
    // In this scenario, totalSum - minTotal would be 0 (if all numbers are negative, totalSum == minTotal),
    // which is incorrect as an empty subarray is not allowed and the result should be maxTotal.
    // For example, nums = [-2, -3, -1]. maxTotal = -1. totalSum = -6, minTotal = -6. totalSum - minTotal = 0.
    // The correct answer is -1.
    if (maxTotal < 0) {
        return maxTotal;
    } else {
        // Return the maximum of the two cases
        return max(maxTotal, totalSum - minTotal);
    }
}