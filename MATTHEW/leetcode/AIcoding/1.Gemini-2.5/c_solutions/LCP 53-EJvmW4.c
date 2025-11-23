#include <stdlib.h> // For malloc and free

long long min(long long a, long long b) {
    return a < b ? a : b;
}

int protectCity(int* costs, int costsSize) {
    if (costsSize == 0) {
        return 0;
    }
    if (costsSize == 1) {
        return costs[0];
    }

    // dp[i] represents the minimum cost to protect segments 0 to i.
    // Using long long to prevent potential overflow during intermediate calculations,
    // as costs[i] can be large and sums might exceed INT_MAX.
    long long* dp = (long long*)malloc(sizeof(long long) * costsSize);
    // In competitive programming, malloc failure is usually not handled unless specified.
    // For robustness: if (dp == NULL) return -1;

    // Base case: To protect segment 0, we must place a defense at 0.
    dp[0] = costs[0];

    // Base case: To protect segments 0 and 1.
    // Option 1: Place a defense at 1 (cost costs[1]). Segment 0 still needs protection,
    //           so a defense must also be placed at 0 (cost costs[0]). Total: costs[0] + costs[1].
    // Option 2: Place a defense at 0 (cost costs[0]). This covers both segment 0 and segment 1. Total: costs[0].
    // Since costs are non-negative, costs[0] is always less than or equal to costs[0] + costs[1].
    // So, dp[1] = costs[0].
    // This can also be derived from the general recurrence by assuming dp[-1] = 0.
    dp[1] = min(dp[0] + costs[1], (long long)costs[0]);

    // Fill the DP table for i from 2 to costsSize - 1
    for (int i = 2; i < costsSize; i++) {
        // To ensure segment i is protected, it must be covered by a defense.
        // This defense can either be placed at i or at i-1.

        // Option 1: Place a defense at i.
        // This defense costs costs[i] and covers segments i and i+1.
        // We still need to ensure segments 0 to i-1 are protected.
        // The minimum cost for this is dp[i-1].
        // Total cost for this option: dp[i-1] + costs[i].

        // Option 2: Place a defense at i-1.
        // This defense costs costs[i-1] and covers segments i-1 and i.
        // We still need to ensure segments 0 to i-2 are protected.
        // The minimum cost for this is dp[i-2].
        // Total cost for this option: dp[i-2] + costs[i-1].

        dp[i] = min(dp[i-1] + costs[i], dp[i-2] + costs[i-1]);
    }

    long long result = dp[costsSize - 1];
    free(dp); // Free dynamically allocated memory

    // The problem typically expects an int return.
    // Assuming the final result fits within the int range as per LeetCode problem constraints.
    return (int)result;
}