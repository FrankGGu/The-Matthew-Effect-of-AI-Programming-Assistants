#include <limits.h>
#include <stdlib.h> // For malloc, free

static inline int min(int a, int b) {
    return (a < b) ? a : b;
}

int connectTwoGroups(int** cost, int costSize, int* costColSize) {
    int m = costSize;
    int n = costColSize[0]; // All rows have the same number of columns

    // dp[i][mask] will store the minimum cost to connect group1[0...i-1]
    // such that 'mask' represents the set of group2 points covered by these connections.
    // Each group1[k] (for k < i) is assumed to connect to exactly one group2 point.
    int dp_rows = m + 1;
    int dp_cols = 1 << n;

    int** dp = (int**)malloc(dp_rows * sizeof(int*));
    for (int i = 0; i < dp_rows; ++i) {
        dp[i] = (int*)malloc(dp_cols * sizeof(int));
        for (int j = 0; j < dp_cols; ++j) {
            dp[i][j] = INT_MAX / 2; // Use INT_MAX / 2 to prevent overflow on addition
        }
    }

    dp[0][0] = 0;

    // Fill the DP table
    for (int i = 0; i < m; ++i) { // Iterate through group1 points (group1[i])
        for (int mask = 0; mask < dp_cols; ++mask) { // Iterate through masks of group2 points already covered by group1[0...i-1]
            if (dp[i][mask] == INT_MAX / 2) {
                continue;
            }
            for (int j = 0; j < n; ++j) { // group1[i] connects to group2[j]
                int new_mask = mask | (1 << j);
                dp[i+1][new_mask] = min(dp[i+1][new_mask], dp[i][mask] + cost[i][j]);
            }
        }
    }

    // After the DP, dp[m][mask] contains the minimum cost to connect all group1 points
    // (each to exactly one group2 point), and 'mask' represents the covered group2 points.
    // Now, we need to ensure all group2 points are covered.
    // Any group2 point not covered by 'mask' must be covered by an additional connection
    // from some group1 point. We choose the cheapest possible connection for each such group2 point.

    // Precompute minimum cost to cover each group2 point 'j' from any group1 point 'k'.
    int* min_cost_to_cover_group2_j = (int*)malloc(n * sizeof(int));
    for (int j = 0; j < n; ++j) {
        min_cost_to_cover_group2_j[j] = INT_MAX / 2;
        for (int k = 0; k < m; ++k) {
            min_cost_to_cover_group2_j[j] = min(min_cost_to_cover_group2_j[j], cost[k][j]);
        }
    }

    int final_ans = INT_MAX / 2;

    // Iterate through all possible final masks for group2 points
    for (int mask = 0; mask < dp_cols; ++mask) {
        if (dp[m][mask] == INT_MAX / 2) {
            continue;
        }
        int current_cost = dp[m][mask];
        // Add costs for any group2 points not covered by this mask
        for (int j = 0; j < n; ++j) {
            if (!((mask >> j) & 1)) { // If group2[j] is not covered
                current_cost += min_cost_to_cover_group2_j[j];
            }
        }
        final_ans = min(final_ans, current_cost);
    }

    // Free allocated memory
    for (int i = 0; i < dp_rows; ++i) {
        free(dp[i]);
    }
    free(dp);
    free(min_cost_to_cover_group2_j);

    return final_ans;
}