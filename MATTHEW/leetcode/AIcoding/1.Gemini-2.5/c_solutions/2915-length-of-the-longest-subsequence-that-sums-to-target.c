#include <stdlib.h> // For malloc, free
#include <string.h> // For memset

int max(int a, int b) {
    return a > b ? a : b;
}

int longestSubsequence(int** coins, int coinsSize, int* coinsColSize, int target) {
    // dp[s] will store the maximum length of a subsequence that sums to 's'.
    // Initialize with -1 to indicate that no sum 's' is reachable yet.
    // dp[0] will be initialized to 0, meaning a sum of 0 can be achieved with a length of 0.
    int* dp = (int*)malloc((target + 1) * sizeof(int));

    // Handle potential malloc failure (though often not strictly necessary in LeetCode environments)
    if (dp == NULL) {
        return -1; // Or handle error appropriately
    }

    // Initialize all dp values to -1
    memset(dp, -1, (target + 1) * sizeof(int));

    // Base case: sum 0 can be achieved with a subsequence of length 0
    dp[0] = 0;

    // Iterate through each coin (value, length pair)
    for (int i = 0; i < coinsSize; ++i) {
        int value = coins[i][0];
        int length = coins[i][1];

        // Iterate 's' from target down to 'value'.
        // This reverse iteration order is crucial for the 0/1 knapsack problem
        // to ensure that each coin is used at most once for a given sum 's'.
        // dp[s - value] will refer to a state calculated *before* the current coin was considered.
        for (int s = target; s >= value; --s) {
            // If a sum (s - value) was previously reachable
            if (dp[s - value] != -1) {
                // We can form sum 's' by adding the current coin.
                // Update dp[s] with the maximum length found so far for this sum.
                dp[s] = max(dp[s], dp[s - value] + length);
            }
        }
    }

    // The result is the maximum length for the target sum.
    // If dp[target] is still -1, it means the target sum is not achievable.
    int result = dp[target];

    // Free the dynamically allocated memory
    free(dp);

    return result;
}