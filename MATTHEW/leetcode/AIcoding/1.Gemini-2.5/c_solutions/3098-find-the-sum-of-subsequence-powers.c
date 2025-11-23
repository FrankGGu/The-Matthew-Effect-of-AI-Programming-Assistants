#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

long long power(long long base, int exp, int mod) {
    long long res = 1;
    base %= mod;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % mod;
        base = (base * base) % mod;
        exp /= 2;
    }
    return res;
}

int custom_upper_bound(int* arr, int size, long long val) {
    int low = 0, high = size;
    int ans = size;
    while (low < high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] > val) {
            ans = mid;
            high = mid;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

int sumSubsequencePowers(int* nums, int numsSize, int k, int p) {
    // If subsequence length k is less than 2, its power is 0.
    if (k < 2) {
        return 0;
    }

    int MOD = 1e9 + 7;

    // Sort the input array nums
    qsort(nums, numsSize, sizeof(int), compare);

    // Collect all unique positive differences nums[j] - nums[i]
    // Max possible differences: numsSize * (numsSize - 1) / 2
    int max_diffs_count = numsSize * (numsSize - 1) / 2;
    int* diff_storage = (int*)malloc(sizeof(int) * max_diffs_count);
    int current_diff_count = 0;

    for (int i = 0; i < numsSize; ++i) {
        for (int j = i + 1; j < numsSize; ++j) {
            int diff = nums[j] - nums[i];
            if (diff > 0) {
                diff_storage[current_diff_count++] = diff;
            }
        }
    }

    // Sort the collected differences to easily find unique ones
    qsort(diff_storage, current_diff_count, sizeof(int), compare);

    // Create the list of distinct difference thresholds
    // It will contain 0 (for D_prev) and all unique positive differences
    int* distinct_diffs = (int*)malloc(sizeof(int) * (current_diff_count + 1));
    int distinct_diffs_count = 0;
    distinct_diffs[distinct_diffs_count++] = 0; // The initial D_prev for the first D_curr

    if (current_diff_count > 0) {
        distinct_diffs[distinct_diffs_count++] = diff_storage[0];
        for (int i = 1; i < current_diff_count; ++i) {
            if (diff_storage[i] != distinct_diffs[distinct_diffs_count - 1]) {
                distinct_diffs[distinct_diffs_count++] = diff_storage[i];
            }
        }
    }
    free(diff_storage);

    long long total_sum = 0;

    // Dynamically allocate 2D DP tables
    // dp[len][i]: count of subsequences of length 'len' ending at nums[i]
    long long (*dp)[numsSize] = (long long (*)[numsSize])calloc((k + 1) * numsSize, sizeof(long long));
    // prefix_sum_dp[len][i]: sum of dp[len][0]...dp[len][i]
    long long (*prefix_sum_dp)[numsSize] = (long long (*)[numsSize])calloc((k + 1) * numsSize, sizeof(long long));

    // Iterate through each distinct difference threshold
    for (int idx = 1; idx < distinct_diffs_count; ++idx) {
        int D_curr = distinct_diffs[idx];
        int D_prev = distinct_diffs[idx - 1];

        // Reset dp and prefix_sum_dp for the current D_curr calculation
        // calloc initializes to zero, but subsequent iterations need explicit reset
        for (int row = 0; row <= k; ++row) {
            memset(dp[row], 0, numsSize * sizeof(long long));
            memset(prefix_sum_dp[row], 0, numsSize * sizeof(long long));
        }

        // Base case: subsequences of length 1
        for (int i = 0; i < numsSize; ++i) {
            dp[1][i] = 1;
        }
        // Compute prefix sums for length 1
        prefix_sum_dp[1][0] = dp[1][0];
        for (int i = 1; i < numsSize; ++i) {
            prefix_sum_dp[1][i] = (prefix_sum_dp[1][i-1] + dp[1][i]) % MOD;
        }

        // Fill DP table for lengths 2 to k
        for (int len = 2; len <= k; ++len) {
            for (int i = 0; i < numsSize; ++i) { // current element nums[i]
                long long target_val = (long long)nums[i] - D_curr;

                // Find max_prev_idx such that nums[max_prev_idx] <= target_val
                // Search in nums[0...i-1] for previous elements
                int ub_idx = custom_upper_bound(nums, i, target_val);
                int max_prev_idx = ub_idx - 1;

                if (max_prev_idx >= 0) {
                    dp[len][i] = prefix_sum_dp[len-1][max_prev_idx];
                }
            }
            // Compute prefix sums for the current length 'len'
            prefix_sum_dp[len][0] = dp[len][0];
            for (int i = 1; i < numsSize; ++i) {
                prefix_sum_dp[len][i] = (prefix_sum_dp[len][i-1] + dp[len][i]) % MOD;
            }
        }

        // C_D_curr is the total count of subsequences of length k
        // where all adjacent differences are >= D_curr
        long long C_D_curr = prefix_sum_dp[k][numsSize-1];

        // Calculate (D_curr^p - D_prev^p) % MOD
        long long pow_D_curr = power(D_curr, p, MOD);
        long long pow_D_prev = power(D_prev, p, MOD);

        long long term_diff = (pow_D_curr - pow_D_prev + MOD) % MOD;

        // Add contribution to total_sum
        total_sum = (total_sum + (term_diff * C_D_curr) % MOD) % MOD;
    }

    // Free dynamically allocated memory
    free(dp);
    free(prefix_sum_dp);
    free(distinct_diffs);

    return (int)total_sum;
}