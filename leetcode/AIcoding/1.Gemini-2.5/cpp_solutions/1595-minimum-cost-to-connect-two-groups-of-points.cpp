#include <vector>
#include <algorithm>

class Solution {
public:
    int connectTwoGroups(std::vector<std::vector<int>>& cost) {
        int n = cost.size();
        int m = cost[0].size();

        // dp[mask] stores the minimum cost to connect points in group2 represented by 'mask'.
        // This DP array is updated 'n' times, once for each point in group1.
        // After processing point 'i' from group1, dp[mask] will contain the minimum cost
        // to connect group1 points 0 to i, such that group2 points in 'mask' are covered.
        std::vector<int> dp(1 << m, 1e9); // Initialize with a large value (infinity)
        dp[0] = 0; // Base case: no points connected, cost is 0

        for (int i = 0; i < n; ++i) { // Iterate through each point in group1 (0 to n-1)
            std::vector<int> next_dp(1 << m, 1e9); // DP table for connections involving current group1 point 'i'

            for (int mask = 0; mask < (1 << m); ++mask) { // Iterate through all possible masks for group2
                if (dp[mask] == 1e9) { // If this state is unreachable from previous group1 points, skip
                    continue;
                }

                // For the current point 'i' from group1, it must be connected to at least one point in group2.
                // We iterate through all possible points 'j' in group2.
                // We consider connecting point 'i' to point 'j'.
                // This transition implicitly handles point 'i' connecting to multiple points in group2.
                // For example, if 'i' connects to j1 and j2:
                // 1. dp[prev_mask] leads to next_dp[prev_mask | (1 << j1)] with cost dp[prev_mask] + cost[i][j1].
                // 2. Then, this new next_dp[prev_mask | (1 << j1)] value (or an earlier one if it was smaller)
                //    is used to update next_dp[prev_mask | (1 << j1) | (1 << j2)] with cost
                //    next_dp[prev_mask | (1 << j1)] + cost[i][j2].
                //    This effectively sums the costs: dp[prev_mask] + cost[i][j1] + cost[i][j2].
                for (int j = 0; j < m; ++j) {
                    // Update next_dp[new_mask] using dp[current_mask] + cost of connecting 'i' to 'j'.
                    next_dp[mask | (1 << j)] = std::min(next_dp[mask | (1 << j)], dp[mask] + cost[i][j]);
                }
            }
            dp = next_dp; // Update the main dp table for the next iteration (next group1 point)
        }

        // After processing all 'n' points from group1, dp[(1 << m) - 1] will
        // contain the minimum total cost to connect all points in group1 and all points in group2.
        return dp[(1 << m) - 1];
    }
};