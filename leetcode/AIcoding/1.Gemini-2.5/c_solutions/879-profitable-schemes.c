#include <stdlib.h> // For malloc, free
#include <string.h> // For memset

#define MOD 1000000007

int profitableSchemes(int n, int minProfit, int* group, int groupSize, int* profit, int profitSize) {
    // dp[j][k] will store the number of ways to achieve exactly j members and exactly k profit.
    // If the profit exceeds minProfit, it is capped at minProfit.
    int** dp = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; ++i) {
        dp[i] = (int*)malloc((minProfit + 1) * sizeof(int));
        memset(dp[i], 0, (minProfit + 1) * sizeof(int));
    }

    // Base case: 0 members and 0 profit can be achieved in 1 way (by doing nothing).
    dp[0][0] = 1;

    // Iterate through each scheme
    for (int i = 0; i < groupSize; ++i) {
        int current_group_size = group[i];
        int current_profit = profit[i];

        // Iterate members from n down to current_group_size
        // This reverse iteration ensures that each scheme is considered only once
        // for the current DP state calculation (0/1 knapsack style).
        for (int j = n; j >= current_group_size; --j) {
            // Iterate profit from minProfit down to 0
            for (int k = minProfit; k >= 0; --k) {
                // If we have a valid way to achieve (j - current_group_size) members
                // and k profit, we can add the current scheme.
                if (dp[j - current_group_size][k] > 0) {
                    // Calculate the new profit, capping it at minProfit
                    int new_profit_index = k + current_profit;
                    if (new_profit_index > minProfit) {
                        new_profit_index = minProfit;
                    }

                    // Add the number of ways from the previous state to the current state
                    dp[j][new_profit_index] = (dp[j][new_profit_index] + dp[j - current_group_size][k]) % MOD;
                }
            }
        }
    }

    // The total number of profitable schemes is the sum of all ways
    // to achieve at most n members and at least minProfit profit.
    // Since we capped profit at minProfit, dp[j][minProfit] already
    // accumulates all schemes that result in minProfit or more profit.
    long long totalSchemes = 0;
    for (int j = 0; j <= n; ++j) {
        totalSchemes = (totalSchemes + dp[j][minProfit]) % MOD;
    }

    // Free allocated memory
    for (int i = 0; i <= n; ++i) {
        free(dp[i]);
    }
    free(dp);

    return (int)totalSchemes;
}