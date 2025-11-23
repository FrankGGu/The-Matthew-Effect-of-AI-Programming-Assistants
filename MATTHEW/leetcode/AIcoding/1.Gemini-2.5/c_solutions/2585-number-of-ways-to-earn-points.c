#include <stdio.h>
#include <stdlib.h>
#include <string.h> // Required for memset if used, but calloc initializes to zero

int numberOfWaysToEarnPoints(int** types, int typesSize, int* typesColSize, int target) {
    // dp[p] will store the number of ways to earn exactly 'p' points.
    // Using long long to prevent overflow before modulo operation.
    long long* dp = (long long*)calloc(target + 1, sizeof(long long));
    if (dp == NULL) {
        // Handle memory allocation failure
        return 0; 
    }

    const int MOD = 1000000007;

    // Base case: There is one way to earn 0 points (by taking no items).
    dp[0] = 1;

    // Iterate through each type of item
    for (int i = 0; i < typesSize; i++) {
        int count = types[i][0];  // Number of items of current type available
        int points = types[i][1]; // Points awarded by each item of current type

        // Iterate 'p' (current target points) downwards from 'target' to '0'.
        // Iterating downwards ensures that when we calculate dp[p],
        // dp[p - k * points] refers to the state *before* considering the
        // current item type 'i' (i.e., using only items from types 0 to i-1).
        for (int p = target; p >= 0; p--) {
            // For the current point 'p', we can use 'k' items of the current type.
            // 'k' ranges from 1 up to 'count'.
            // dp[p] already holds the ways to make 'p' points using previous item types.
            // We now add ways by using 1, 2, ..., 'count' items of the current type.
            for (int k = 1; k <= count; k++) {
                // Check if it's possible to use 'k' items of the current type
                // (i.e., if 'p' is large enough to subtract 'k * points').
                if (p - k * points >= 0) {
                    // Add the number of ways to make the remaining points (p - k * points)
                    // using previous item types to the current dp[p].
                    dp[p] = (dp[p] + dp[p - k * points]) % MOD;
                } else {
                    // If p - k * points is negative, we cannot use 'k' items.
                    // Since 'k' is increasing, we also cannot use 'k+1', 'k+2', etc. items.
                    break;
                }
            }
        }
    }

    int result = (int)dp[target];
    free(dp); // Free dynamically allocated memory
    return result;
}