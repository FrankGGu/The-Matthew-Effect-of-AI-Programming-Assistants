#include <stdio.h>
#include <stdlib.h>

#define MAX_ELEMENT_VALUE 100

#define MOD 1000000007

int dp[2][MAX_ELEMENT_VALUE + 1];

int findSumOfArrayProductOfMagicalSequences(int n, int k) {
    if (n <= 0) {
        return 0; // No sequences of non-positive length.
    }
    if (k <= 0) {
        return 0; // No valid elements to form sequences.
    }

    // Initialize DP for sequences of length 1.
    // A sequence of length 1 ending with `j` has a product of `j`.
    for (int j = 1; j <= k; ++j) {
        dp[0][j] = j;
    }

    int current_row = 0; // Represents dp for length `i`
    int prev_row = 0;    // Represents dp for length `i-1`

    // Iterate for sequence lengths from 2 up to n.
    for (int i = 2; i <= n; ++i) {
        prev_row = current_row;
        current_row = 1 - current_row; // Toggle to the other row (0 or 1)

        // Clear the current row for new calculations to avoid carrying over old values.
        for (int j = 1; j <= k; ++j) {
            dp[current_row][j] = 0;
        }

        // Iterate through all possible values for the last element of the current sequence.
        for (int current_val = 1; current_val <= k; ++current_val) {
            // Iterate through all possible values for the last element of the previous sequence.
            for (int prev_val = 1; prev_val <= k; ++prev_val) {
                // This is where the "magical" rule would be applied.
                // In this generic solution, we assume any `current_val` can follow any `prev_val`.
                // The sum of products for sequences of length `i` ending with `current_val`
                // is formed by appending `current_val` to all sequences of length `i-1`
                // ending with `prev_val`.
                // The product for such an extended sequence would be (product of prev_sequence) * current_val.

                dp[current_row][current_val] = (dp[current_row][current_val] +
                                               (long long)dp[prev_row][prev_val] * current_val) % MOD;
            }
        }
    }

    // After filling the DP table up to length `n`, sum up all products for sequences of length `n`.
    long long total_sum = 0;
    for (int j = 1; j <= k; ++j) {
        total_sum = (total_sum + dp[current_row][j]) % MOD;
    }

    return (int)total_sum;
}