#include <stdio.h>
#include <stdlib.h>
#include <limits.h> // For LLONG_MIN

#define MIN_SUM -2500
#define MAX_SUM 2500
#define OFFSET (0 - MIN_SUM) // Offset to map sum to non-negative index
#define SUM_RANGE (MAX_SUM - MIN_SUM + 1) // Total number of possible sum values (5001)

long long dp[SUM_RANGE][2];
long long next_dp[SUM_RANGE][2];

long long max(long long a, long long b) {
    return a > b ? a : b;
}

int maximumProduct(int* nums, int numsSize, int k) {
    // Initialize dp table with a very small negative number to represent unreachable states.
    // Use LLONG_MIN / 2 to avoid overflow when multiplying by positive numbers,
    // as LLONG_MIN * N (N > 1) could wrap around.
    for (int i = 0; i < SUM_RANGE; ++i) {
        dp[i][0] = LLONG_MIN / 2;
        dp[i][1] = LLONG_MIN / 2;
    }

    for (int i = 0; i < numsSize; ++i) {
        int num = nums[i];

        // Initialize next_dp for the current iteration.
        // It initially holds all states from dp (subsequences not including current num).
        for (int j = 0; j < SUM_RANGE; ++j) {
            next_dp[j][0] = dp[j][0];
            next_dp[j][1] = dp[j][1];
        }

        // Option 1: Start a new subsequence with `num`.
        // The first term in any subsequence is always added, so its sign is positive (0).
        long long current_sum_start = num;
        if (current_sum_start >= MIN_SUM && current_sum_start <= MAX_SUM) {
            int sum_idx = current_sum_start + OFFSET;
            // The product is just num itself.
            next_dp[sum_idx][0] = max(next_dp[sum_idx][0], (long long)num);
        }

        // Option 2: Extend existing subsequences from `dp` (which are from nums[0...i-1]).
        for (int prev_sum_idx = 0; prev_sum_idx < SUM_RANGE; ++prev_sum_idx) {
            // Only consider reachable previous states
            if (dp[prev_sum_idx][0] == LLONG_MIN / 2 && dp[prev_sum_idx][1] == LLONG_MIN / 2) {
                continue;
            }

            long long prev_sum_val = (long long)prev_sum_idx - OFFSET;

            // Extend with `num` as a positive term.
            // This means the previous term must have been subtracted (sign 1).
            if (dp[prev_sum_idx][1] != LLONG_MIN / 2) {
                long long current_sum_val = prev_sum_val + num;
                if (current_sum_val >= MIN_SUM && current_sum_val <= MAX_SUM) {
                    int new_sum_idx = current_sum_val + OFFSET;
                    long long product = dp[prev_sum_idx][1] * num;
                    next_dp[new_sum_idx][0] = max(next_dp[new_sum_idx][0], product);
                }
            }

            // Extend with `num` as a negative term.
            // This means the previous term must have been added (sign 0).
            if (dp[prev_sum_idx][0] != LLONG_MIN / 2) {
                long long current_sum_val = prev_sum_val - num;
                if (current_sum_val >= MIN_SUM && current_sum_val <= MAX_SUM) {
                    int new_sum_idx = current_sum_val + OFFSET;
                    long long product = dp[prev_sum_idx][0] * num;
                    next_dp[new_sum_idx][1] = max(next_dp[new_sum_idx][1], product);
                }
            }
        }

        // Update dp for the next iteration.
        for (int j = 0; j < SUM_RANGE; ++j) {
            dp[j][0] = next_dp[j][0];
            dp[j][1] = next_dp[j][1];
        }
    }

    long long final_max_product = LLONG_MIN / 2;

    // Check for the target sum k, considering both positive and negative last terms.
    int k_idx = k + OFFSET;
    if (k_idx >= 0 && k_idx < SUM_RANGE) {
        final_max_product = max(final_max_product, dp[k_idx][0]);
        final_max_product = max(final_max_product, dp[k_idx][1]);
    }

    // If no subsequence achieves sum k, return -1. Otherwise, return the max product.
    // The problem states the return type is int, assuming the final product fits in int.
    return (final_max_product == LLONG_MIN / 2) ? -1 : (int)final_max_product;
}