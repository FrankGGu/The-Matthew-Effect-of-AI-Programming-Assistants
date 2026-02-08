#include <stdbool.h>
#include <string.h> // For memset, if dp were a local array and not implicitly zero-initialized global/static

#define MAX_SUM_VAL 300000

unsigned long long dp[MAX_SUM_VAL + 1];

bool splitArraySameAverage(int* nums, int numsSize) {
    // An array with only one element cannot be split into two non-empty subarrays.
    if (numsSize == 1) {
        return false;
    }

    long long totalSum = 0;
    for (int i = 0; i < numsSize; ++i) {
        totalSum += nums[i];
    }

    // Initialize dp array for each test case.
    // Global/static arrays are zero-initialized, but for multiple test cases,
    // we need to reset it. A memset or loop is appropriate.
    // Since MAX_SUM_VAL is large, we only need to reset up to the maximum possible sum for the current numsSize.
    // Max sum for current numsSize is numsSize * 10000.
    int currentMaxSum = numsSize * 10000;
    for (int i = 0; i <= currentMaxSum; ++i) {
        dp[i] = 0ULL;
    }

    // Sum 0 can be formed with 0 elements. Set the 0-th bit.
    dp[0] = 1ULL; 

    // Iterate through each number in nums to build the DP table.
    for (int i = 0; i < numsSize; ++i) {
        int num = nums[i];
        // Iterate sums from max possible down to current num to avoid using the same number multiple times in one subset.
        for (int s = currentMaxSum; s >= num; --s) {
            // Update dp[s] using dp[s - num].
            // If sum (s - num) can be formed with 'k' elements (k-th bit is set in dp[s-num]),
            // then sum 's' can be formed with 'k+1' elements by adding 'num'.
            // This is achieved by shifting dp[s-num] left by 1.
            // We OR this with existing dp[s] to combine all possibilities.
            dp[s] |= (dp[s - num] << 1);
        }
    }

    // Check for each possible subset size 'k'.
    // 'k' represents the number of elements in subarray A.
    // 'A' must be non-empty (k >= 1) and 'B' must be non-empty (numsSize - k >= 1 => k < numsSize).
    for (int k = 1; k < numsSize; ++k) {
        // The condition for same average is sum(A) / len(A) == totalSum / numsSize.
        // This simplifies to sum(A) * numsSize == totalSum * len(A).
        // For sum(A) to be an integer, (totalSum * k) must be divisible by numsSize.
        if ((totalSum * k) % numsSize == 0) {
            long long targetSumK = (totalSum * k) / numsSize;

            // Check if targetSumK is within the calculated bounds and if it can be formed with exactly 'k' elements.
            // The k-th bit of dp[targetSumK] should be set.
            if (targetSumK <= currentMaxSum && (dp[targetSumK] & (1ULL << k))) {
                return true;
            }
        }
    }

    return false;
}