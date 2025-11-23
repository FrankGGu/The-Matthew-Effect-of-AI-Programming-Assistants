#include <stdlib.h> // For malloc, free
#include <string.h> // For memset (optional, can manually zero)

#define MOD 1000000007

int countBalancedPermutations(int n) {
    if (n == 0) {
        return 1; // Conventionally, there's one empty permutation.
    }
    if (n == 1) {
        return 1; // Permutation (1)
    }

    // dp_up_prev[j] stores the number of alternating permutations of length i-1 ending with j,
    // where the last step was an ascent (p[i-2] < p[i-1]).
    // dp_down_prev[j] stores the number of alternating permutations of length i-1 ending with j,
    // where the last step was a descent (p[i-2] > p[i-1]).
    // We use two arrays for current and previous states to optimize space to O(N).
    long long* dp_up_prev = (long long*)calloc(n + 1, sizeof(long long));
    long long* dp_down_prev = (long long*)calloc(n + 1, sizeof(long long));
    long long* dp_up_curr = (long long*)calloc(n + 1, sizeof(long long));
    long long* dp_down_curr = (long long*)calloc(n + 1, sizeof(long long));

    // Prefix and suffix sums for optimization
    long long* prefix_sum_down_prev = (long long*)calloc(n + 1, sizeof(long long));
    long long* suffix_sum_up_prev = (long long*)calloc(n + 2, sizeof(long long)); // n+2 for suffix_sum_up_prev[i]

    // Base case for i = 1
    // Permutation (1) can be considered as both an ascent-ending and descent-ending base for recurrence.
    // These values are used to compute for i=2.
    dp_up_prev[1] = 1;
    dp_down_prev[1] = 1;

    for (int i = 2; i <= n; ++i) {
        // Compute prefix sums for dp_down_prev and suffix sums for dp_up_prev
        // These sums are for permutations of length i-1
        prefix_sum_down_prev[0] = 0; // No elements before index 1
        for (int k = 1; k < i; ++k) {
            prefix_sum_down_prev[k] = (prefix_sum_down_prev[k-1] + dp_down_prev[k]) % MOD;
        }

        suffix_sum_up_prev[i] = 0; // No elements after index i-1
        for (int k = i - 1; k >= 1; --k) {
            suffix_sum_up_prev[k] = (suffix_sum_up_prev[k+1] + dp_up_prev[k]) % MOD;
        }

        // Compute dp_up_curr and dp_down_curr for length i
        for (int j = 1; j <= i; ++j) {
            // dp_up_curr[j]: number of alternating permutations of length i ending with j,
            // where the last step was an ascent (p[i-1] < p[i]=j).
            // This is the sum of dp_down_prev[k] for k from 1 to j-1.
            dp_up_curr[j] = prefix_sum_down_prev[j-1];

            // dp_down_curr[j]: number of alternating permutations of length i ending with j,
            // where the last step was a descent (p[i-1] > p[i]=j).
            // This is the sum of dp_up_prev[k] for k from j to i-1.
            dp_down_curr[j] = suffix_sum_up_prev[j];
        }

        // Prepare for next iteration: current becomes previous
        for (int j = 1; j <= i; ++j) {
            dp_up_prev[j] = dp_up_curr[j];
            dp_down_prev[j] = dp_down_curr[j];
        }
    }

    long long total_balanced_permutations = 0;
    for (int j = 1; j <= n; ++j) {
        total_balanced_permutations = (total_balanced_permutations + dp_up_prev[j]) % MOD;
        total_balanced_permutations = (total_balanced_permutations + dp_down_prev[j]) % MOD;
    }

    // Free allocated memory
    free(dp_up_prev);
    free(dp_down_prev);
    free(dp_up_curr);
    free(dp_down_curr);
    free(prefix_sum_down_prev);
    free(suffix_sum_up_prev);

    return (int)total_balanced_permutations;
}