#include <vector>
#include <algorithm>
#include <climits> // For LLONG_MAX
#include <cmath>   // For std::abs

class Solution {
public:
    long long minimumTotalDistance(std::vector<std::vector<int>>& robot, std::vector<std::vector<int>>& factory) {
        // Sort robots and factories by their positions.
        // This is crucial for the dynamic programming approach to ensure optimal substructure
        // and avoid "crossing" assignments.
        std::sort(robot.begin(), robot.end());
        std::sort(factory.begin(), factory.end());

        int n = robot.size();    // Number of robots
        int m = factory.size();  // Number of factories

        // dp[i][j] represents the minimum total distance to repair items for the first 'i' robots
        // (i.e., robots 0 to i-1) using the first 'j' factories (i.e., factories 0 to j-1).
        // The size of the DP table will be (n + 1) x (m + 1).
        std::vector<std::vector<long long>> dp(n + 1, std::vector<long long>(m + 1, LLONG_MAX));

        // Base case: If there are no robots (i=0), the total distance is 0, regardless of the number of factories.
        for (int j = 0; j <= m; ++j) {
            dp[0][j] = 0;
        }

        // Iterate through factories. `j_idx` represents the current factory being considered (factory[j_idx]).
        // The DP state `dp[i][j_idx+1]` will be computed.
        for (int j_idx = 0; j_idx < m; ++j_idx) {
            // Iterate through robots. `i_idx` represents the number of robots considered (robots 0 to i_idx-1).
            // The DP state `dp[i_idx+1][j_idx+1]` will be computed.
            for (int i_idx = 0; i_idx < n; ++i_idx) {
                // Option 1: Don't use the current factory (factory[j_idx]) for any of the first `i_idx+1` robots.
                // In this case, the cost is the same as using factories 0 to `j_idx-1` for robots 0 to `i_idx`.
                if (dp[i_idx + 1][j_idx] != LLONG_MAX) { // Ensure the previous state is reachable
                    dp[i_idx + 1][j_idx + 1] = std::min(dp[i_idx + 1][j_idx + 1], dp[i_idx + 1][j_idx]);
                }

                // Option 2: Use the current factory (factory[j_idx]) to repair items for a contiguous segment of robots.
                // We try to assign robots from `k_idx` to `i_idx` (inclusive) to factory[j_idx].
                long long current_capacity_used = 0;
                long long current_cost_for_segment = 0;

                // Iterate backwards from the current robot `i_idx` down to `0`.
                // `k_idx` is the starting robot index for the segment of robots assigned to factory[j_idx].
                // So, robots `k_idx` to `i_idx` are assigned to factory[j_idx].
                for (int k_idx = i_idx; k_idx >= 0; --k_idx) {
                    current_capacity_used += robot[k_idx][1]; // Add capacity needed by robot[k_idx]
                    // Add the distance cost for robot[k_idx] to factory[j_idx]
                    current_cost_for_segment += (long long)robot[k_idx][1] * std::abs(robot[k_idx][0] - factory[j_idx][0]);

                    // If factory[j_idx] does not have enough capacity to repair items for robots `k_idx` to `i_idx`,
                    // then this assignment is invalid. Break and try a smaller segment (i.e., a larger `k_idx`).
                    if (current_capacity_used > factory[j_idx][1]) {
                        break;
                    }

                    // If robots `k_idx` to `i_idx` are assigned to factory[j_idx],
                    // then the remaining robots (0 to `k_idx-1`) must have been repaired by factories (0 to `j_idx-1`).
                    // This corresponds to the state `dp[k_idx][j_idx]`.
                    if (dp[k_idx][j_idx] != LLONG_MAX) { // Ensure dp[k_idx][j_idx] is a reachable state
                        dp[i_idx + 1][j_idx + 1] = std::min(dp[i_idx + 1][j_idx + 1], dp[k_idx][j_idx] + current_cost_for_segment);
                    }
                }
            }
        }

        // The final answer is the minimum total distance to repair all `n` robots
        // using all `m` factories.
        return dp[n][m];
    }
};