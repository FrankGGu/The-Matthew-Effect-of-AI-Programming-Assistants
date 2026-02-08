#include <stdlib.h> // For malloc, free
#include <limits.h> // For LLONG_MIN

long long max(long long a, long long b) {
    return a > b ? a : b;
}

long long max_sum_of_k_subarrays_with_length_at_least_m(int* nums, int numsSize, int k, int m) {
    if (numsSize == 0 || k == 0) {
        return 0;
    }

    // If it's impossible to form k subarrays of length at least m
    // (e.g., k=2, m=2, numsSize=3, then k*m=4 > numsSize=3)
    if ((long long)k * m > numsSize) {
        return 0; // Return 0 as no valid solution can be formed
    }

    // prefixSum[i] stores the sum of nums[0...i-1]
    // prefixSum[0] = 0
    // prefixSum[1] = nums[0]
    // ...
    // prefixSum[numsSize] = sum of all elements
    long long* prefixSum = (long long*)malloc((numsSize + 1) * sizeof(long long));
    prefixSum[0] = 0;
    for (int i = 0; i < numsSize; ++i) {
        prefixSum[i+1] = prefixSum[i] + nums[i];
    }

    // dp[j][i] = maximum sum using j subarrays, considering elements nums[0...i-1]
    // (i.e., elements covered by prefixSum[i])
    // dp table size (k+1) x (numsSize+1)
    long long** dp = (long long**)malloc((k + 1) * sizeof(long long*));
    for (int j = 0; j <= k; ++j) {
        dp[j] = (long long*)malloc((numsSize + 1) * sizeof(long long));
        for (int i = 0; i <= numsSize; ++i) {
            dp[j][i] = LLONG_MIN; // Initialize with a very small number to represent invalid state
        }
    }

    // Base case: 0 subarrays, sum is 0
    for (int i = 0; i <= numsSize; ++i) {
        dp[0][i] = 0;
    }

    for (int j = 1; j <= k; ++j) {
        // max_prev_val_term stores max(dp[j-1][x] - prefixSum[x])
        // for valid 'x' values up to current 'i-m'.
        long long max_prev_val_term = LLONG_MIN; 

        for (int i = 1; i <= numsSize; ++i) {
            // Option 1: The j-th subarray does not use nums[i-1].
            // So, the maximum sum using j subarrays considering elements up to nums[i-1]
            // is the same as considering elements up to nums[i-2].
            dp[j][i] = dp[j][i-1];

            // Option 2: The j-th subarray ends at nums[i-1].
            // This subarray must have length at least 'm'.
            // It starts at index 'x' (in the original nums array), where x <= i-m.
            // The sum of this subarray is prefixSum[i] - prefixSum[x].
            // The previous j-1 subarrays must use elements up to nums[x-1].
            // So, we need dp[j-1][x].
            // We want to maximize: dp[j-1][x] + (prefixSum[i] - prefixSum[x])
            // which can be rewritten as: prefixSum[i] + (dp[j-1][x] - prefixSum[x]).

            // 'x' is the index in prefixSum (and also the starting index of the current subarray in nums).
            // 'x' must be at least (j-1)*m to allow for j-1 previous subarrays.
            // 'x' must be at most i-m to allow for the current subarray of length 'm' ending at i-1.

            // Check if 'i-m' is a valid 'x' (starting index of current subarray) for updating max_prev_val_term.
            // This 'x' corresponds to the end of the previous (j-1) subarrays.
            // So, we are considering `dp[j-1][i-m]` which is the max sum of `j-1` subarrays using `nums[0...i-m-1]`.
            if (i - m >= (j - 1) * m) {
                // Only update max_prev_val_term if dp[j-1][i-m] is a valid sum.
                if (dp[j-1][i-m] != LLONG_MIN) {
                    max_prev_val_term = max(max_prev_val_term, dp[j-1][i-m] - prefixSum[i-m]);
                }
            }

            // If a valid max_prev_val_term was found for any 'x' in the range,
            // then we can potentially form the j-th subarray ending at i-1.
            if (max_prev_val_term != LLONG_MIN) {
                dp[j][i] = max(dp[j][i], prefixSum[i] + max_prev_val_term);
            }
        }
    }

    long long result = dp[k][numsSize];

    // Free allocated memory
    for (int j = 0; j <= k; ++j) {
        free(dp[j]);
    }
    free(dp);
    free(prefixSum);

    // If no solution found (result is LLONG_MIN), return 0.
    // This covers cases like k*m > numsSize (already handled, but defensive)
    // or if all possible sums are negative and LLONG_MIN was not replaced.
    return result == LLONG_MIN ? 0 : result;
}