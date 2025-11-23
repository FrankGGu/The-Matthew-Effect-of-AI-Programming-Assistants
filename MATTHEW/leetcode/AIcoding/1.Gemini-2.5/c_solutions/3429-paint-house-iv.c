#include <limits.h> // For INT_MAX, though not directly used for INF value

#define INF 1000000001LL // Use LL suffix for long long literal

long long min(long long a, long long b) {
    return a < b ? a : b;
}

int minCost(int* houses, int housesSize, int** cost, int costSize, int* costColSize, int n, int target) {
    int m = housesSize;

    // dp[i][j][k] represents the minimum cost to paint houses from 0 to i,
    // where house i is painted with color j (1-indexed),
    // and there are exactly k neighborhoods.
    // Dimensions:
    // i: current house index (0 to m-1)
    // j: color of current house (1 to n)
    // k: number of neighborhoods (1 to target)
    long long dp[m][n + 1][target + 1];

    // Initialize dp table with INF
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j <= n; ++j) {
            for (int k = 0; k <= target; ++k) {
                dp[i][j][k] = INF;
            }
        }
    }

    // Base case: processing the first house (house 0)
    if (houses[0] != 0) { // House 0 is already painted
        // Cost is 0, and it forms 1 neighborhood
        dp[0][houses[0]][1] = 0;
    } else { // House 0 is unpainted
        // Try painting it with each possible color
        for (int c = 1; c <= n; ++c) {
            // Cost is cost[0][c-1], and it forms 1 neighborhood
            dp[0][c][1] = cost[0][c - 1];
        }
    }

    // Iterate for subsequent houses from 1 to m-1
    for (int i = 1; i < m; ++i) {
        // Iterate over all possible previous colors and neighborhood counts
        for (int prev_c = 1; prev_c <= n; ++prev_c) {
            for (int prev_k = 1; prev_k <= target; ++prev_k) {
                // If the previous state was unreachable, skip
                if (dp[i - 1][prev_c][prev_k] == INF) {
                    continue;
                }

                if (houses[i] != 0) { // Current house 'i' is pre-painted
                    int curr_c = houses[i];
                    // If current color is same as previous, neighborhoods don't increase.
                    // Otherwise, a new neighborhood is formed.
                    int curr_k = prev_k + (curr_c == prev_c ? 0 : 1);

                    // If the number of neighborhoods does not exceed target
                    if (curr_k <= target) {
                        // Update dp state for current house, color, and neighborhood count
                        // Cost is simply carried over from the previous state as this house is pre-painted.
                        dp[i][curr_c][curr_k] = min(dp[i][curr_c][curr_k], dp[i - 1][prev_c][prev_k]);
                    }
                } else { // Current house 'i' is unpainted
                    // Try painting current house with every possible color
                    for (int curr_c = 1; curr_c <= n; ++curr_c) {
                        // Calculate new neighborhood count
                        int curr_k = prev_k + (curr_c == prev_c ? 0 : 1);

                        // If the number of neighborhoods does not exceed target
                        if (curr_k <= target) {
                            // Update dp state. Add the cost of painting house 'i' with 'curr_c'.
                            dp[i][curr_c][curr_k] = min(dp[i][curr_c][curr_k], dp[i - 1][prev_c][prev_k] + cost[i][curr_c - 1]);
                        }
                    }
                }
            }
        }
    }

    // After processing all houses, find the minimum cost for the last house (m-1)
    // with exactly 'target' neighborhoods.
    long long min_total_cost = INF;
    for (int c = 1; c <= n; ++c) {
        min_total_cost = min(min_total_cost, dp[m - 1][c][target]);
    }

    // If min_total_cost is still INF, it means target neighborhoods could not be achieved.
    return (min_total_cost == INF) ? -1 : (int)min_total_cost;
}