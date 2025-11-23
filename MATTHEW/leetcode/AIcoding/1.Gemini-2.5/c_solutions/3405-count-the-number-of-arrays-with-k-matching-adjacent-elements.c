#include <stdio.h>
#include <string.h> // For memset

#define MOD 1000000007

int countArrays(int n, int m, int k) {
    // dp_val[i_parity][l] stores the number of arrays of length `i`,
    // ending with any specific value `j` (from 1 to m),
    // having exactly `l` matching adjacent elements.
    // Due to the symmetry of the problem (all values 1 to m are treated identically),
    // this count is the same regardless of which specific value `j` the array ends with.
    // We use space optimization for the `i` dimension, using only two rows (current and previous).
    long long dp_val[2][k + 1];

    // Initialize dp_val table with 0s.
    // dp_val[0] for even lengths, dp_val[1] for odd lengths.
    memset(dp_val, 0, sizeof(dp_val));

    // Base case: For an array of length 1 (i=1),
    // there is 1 way to form it ending with any specific value `j` (e.g., [j]),
    // and it has 0 matching adjacent elements.
    dp_val[1 % 2][0] = 1; // For i=1, 1%2 = 1.

    // Iterate for array length from 2 to n.
    for (int i = 2; i <= n; i++) {
        int curr = i % 2;         // Current row index
        int prev = (i - 1) % 2;   // Previous row index

        // Clear the current row for new calculations to avoid carrying over old values.
        memset(dp_val[curr], 0, sizeof(dp_val[curr]));

        // Iterate for the number of matching adjacent elements `l`.
        for (int l = 0; l <= k; l++) {
            // Case 1: The current element arr[i] is the same as the previous element arr[i-1].
            // This adds one match. So, we need `l-1` matches from the first `i-1` elements.
            // This is only possible if `l > 0`.
            if (l > 0) {
                dp_val[curr][l] = (dp_val[curr][l] + dp_val[prev][l - 1]) % MOD;
            }

            // Case 2: The current element arr[i] is different from the previous element arr[i-1].
            // This adds zero matches. So, we need `l` matches from the first `i-1` elements.
            // The previous element could be any of the `(m-1)` values that are different from `arr[i]`.
            // The total number of ways to form an array of length `i-1` with `l` matches
            // (ending with ANY value) is `m * dp_val[prev][l]`.
            // From this total, we subtract the ways where the previous element was `arr[i]` itself
            // (which is `dp_val[prev][l]`).
            // So, the number of ways is `(m * dp_val[prev][l] - dp_val[prev][l]) = (m - 1) * dp_val[prev][l]`.
            long long non_match_ways = (long long)(m - 1) * dp_val[prev][l];
            dp_val[curr][l] = (dp_val[curr][l] + non_match_ways) % MOD;
        }
    }

    // The final answer is the total number of arrays of length `n` with `k` matches.
    // Since `dp_val[n % 2][k]` gives the count for arrays ending with a *specific* value,
    // and there are `m` possible values for the last element, we multiply by `m`.
    long long total_arrays = (long long)m * dp_val[n % 2][k];
    return (int)(total_arrays % MOD);
}