#include <vector>
#include <algorithm>
#include <limits> // Required for std::numeric_limits, though a custom INF is used here

class Solution {
public:
    int minSideJumps(std::vector<int>& obstacles) {
        int n = obstacles.size() - 1;

        // dp[j] represents the minimum side jumps to reach the current point in lane j.
        // Lanes are 1-indexed (1, 2, 3), so we use dp[1], dp[2], dp[3].
        // dp[0] is unused.

        // Initialize with a large value (infinity) for unreachable states.
        // A value larger than any possible number of jumps (max N jumps + 1)
        const int INF = n + 2; 

        std::vector<int> dp(4, INF);

        // Base case: At point 0 (start), the frog is in lane 2.
        // To be in lane 1 or 3 at point 0, one side jump is needed from lane 2.
        dp[1] = 1; // Jump from lane 2 to 1
        dp[2] = 0; // Start in lane 2
        dp[3] = 1; // Jump from lane 2 to 3

        // Iterate through each point from 1 to n.
        for (int i = 1; i <= n; ++i) {
            std::vector<int> next_dp(4, INF);

            // Step 1: Calculate next_dp values considering straight movement from point i-1 to i.
            // If there's an obstacle in a lane at point i, we cannot reach it by moving straight.
            for (int lane = 1; lane <= 3; ++lane) {
                if (obstacles[i] != lane) { // No obstacle in this lane at point i
                    next_dp[lane] = dp[lane];
                }
            }

            // Step 2: Propagate side jumps at point i.
            // A frog can jump from any lane k to lane j at point i.
            // This is like finding the shortest path in a graph of 3 nodes (lanes) at point i.
            // Since multiple jumps are allowed at the same point, we need to ensure all paths are considered.
            // Iterating 3 times ensures that the minimum cost propagates across all lanes (e.g., from lane 1 to 3 via 2).
            // This is effectively a Bellman-Ford-like step for the current point's lanes.
            for (int k = 0; k < 3; ++k) { // Three passes for full propagation of jump costs
                for (int lane = 1; lane <= 3; ++lane) {
                    if (obstacles[i] != lane) { // Can be in this lane
                        // Try jumping from other lanes to 'lane' at point 'i'
                        for (int other_lane = 1; other_lane <= 3; ++other_lane) {
                            if (lane == other_lane) continue; // Cannot jump to the same lane
                            if (obstacles[i] != other_lane) { // Can jump from 'other_lane' if it's not blocked at point i
                                next_dp[lane] = std::min(next_dp[lane], next_dp[other_lane] + 1);
                            }
                        }
                    }
                }
            }

            // Update dp for the next iteration.
            dp = next_dp;
        }

        // The minimum side jumps to reach point n in any lane.
        // Use std::min with an initializer list for convenience (C++11).
        return std::min({dp[1], dp[2], dp[3]});
    }
};