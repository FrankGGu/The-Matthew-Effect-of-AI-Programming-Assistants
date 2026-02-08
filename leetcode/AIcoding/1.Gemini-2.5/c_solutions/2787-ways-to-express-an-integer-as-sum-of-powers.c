#include <stdlib.h> // Required for calloc and free

int waysToExpressProducts(int n, int x) {
    long long MOD = 1000000007;

    // dp[i] will store the number of ways to express sum i
    // using distinct powers.
    long long* dp = (long long*)calloc(n + 1, sizeof(long long));
    if (dp == NULL) {
        // Handle memory allocation failure, though LeetCode environments usually guarantee it.
        return 0; 
    }

    // Base case: there is one way to make sum 0 (by choosing no numbers)
    dp[0] = 1;

    // Iterate through possible base numbers 'b'
    // Calculate b^x and use it as an 'item' in our knapsack-like DP
    for (int b = 1; ; ++b) {
        long long current_power = 1;
        // Calculate b^x safely, checking for potential overflow or if it exceeds n
        for (int i = 0; i < x; ++i) {
            // This check prevents current_power * b from overflowing long long
            // and also detects if the next power will exceed n.
            // For b=1, n/b is n, and current_power (which is 1) will not be > n for n >= 1.
            if (current_power > n / b) { 
                current_power = n + 1; // Mark as exceeding n to break the outer loop
                break;
            }
            current_power *= b;
        }

        if (current_power > n) {
            // All subsequent powers (for larger 'b') will also be greater than n
            break; 
        }

        // Apply the knapsack-like DP for distinct items.
        // Iterate 'j' from 'n' down to 'current_power'.
        // This reverse iteration ensures that each 'current_power' is used at most once
        // for any given sum 'j'.
        for (int j = n; j >= current_power; --j) {
            dp[j] = (dp[j] + dp[j - current_power]) % MOD;
        }
    }

    long long result = dp[n];
    free(dp); // Free allocated memory

    return (int)result;
}