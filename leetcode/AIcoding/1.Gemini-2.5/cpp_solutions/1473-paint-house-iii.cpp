#include <vector>
#include <algorithm> // For std::min
#include <limits>    // For std::numeric_limits

class Solution {
public:
    int minCost(std::vector<int>& houses, std::vector<std::vector<int>>& cost, int m, int n, int target) {
        // dp[i][j][k] represents the minimum cost to paint houses from 0 to i-1 (inclusive),
        // such that house i-1 is painted with color j (1-indexed),
        // and there are k neighborhoods formed among these i houses.
        // i: number of houses processed (1 to m)
        // j: color of the current house (1 to n)
        // k: number of neighborhoods (1 to target)

        // Using long long for dp values to avoid potential overflow during intermediate sums.
        // A large value to represent infinity.
        const long long INF = std::numeric_limits<long long>::max() / 2; 

        // dp table dimensions: [houses_processed + 1][colors + 1][neighborhoods + 1]
        // We use 1-based indexing for houses_processed, colors, and neighborhoods for convenience.
        std::vector<std::vector<std::vector<long long>>> dp(m + 1, 
            std::vector<std::vector<long long>>(n + 1, 
                std::vector<long long>(target + 1, INF)));

        // Base case: Before painting any house (0 houses processed, 0 neighborhoods, 0 cost)
        // This state is a bit tricky with 1-based indexing for houses.
        // Let's adjust the DP state to be:
        // dp[i][j][k] = min cost to paint houses 0 to i-1, house i-1 has color j, k neighborhoods.
        // So, i goes from 0 to m-1.
        // Let's re-index dp table to be dp[house_idx][color][neighborhoods]
        // house_idx: 0 to m-1
        // color: 1 to n
        // neighborhoods: 1 to target

        std::vector<std::vector<std::vector<long long>>> dp_current(m, 
            std::vector<std::vector<long long>>(n + 1, 
                std::vector<long long>(target + 1, INF)));

        // Initialize dp for the first house (house 0)
        for (int curr_color = 1; curr_color <= n; ++curr_color) {
            if (houses[0] == 0) { // House 0 is unpainted
                dp_current[0][curr_color][1] = cost[0][curr_color - 1];
            } else if (houses[0] == curr_color) { // House 0 is already painted with curr_color
                dp_current[0][curr_color][1] = 0;
            }
            // If houses[0] is painted but not with curr_color, dp_current[0][curr_color][1] remains INF.
            // If target > 1, dp_current[0][curr_color][>1] remains INF, which is correct (1 house can only form 1 neighborhood).
        }

        // Fill dp table for houses 1 to m-1
        for (int i = 1; i < m; ++i) { // Current house index
            for (int curr_color = 1; curr_color <= n; ++curr_color) { // Color for current house i
                // If house i is already painted and its color is not curr_color,
                // we cannot paint it with curr_color. So, dp_current[i][curr_color][...] remains INF.
                if (houses[i] != 0 && houses[i] != curr_color) {
                    continue;
                }

                long long cost_to_paint_curr = (houses[i] == 0) ? cost[i][curr_color - 1] : 0;

                for (int num_neigh = 1; num_neigh <= target; ++num_neigh) { // Number of neighborhoods up to house i
                    // Case 1: Current house `i` is painted with `curr_color`, which is the same as `prev_color`
                    // of house `i-1`. The number of neighborhoods remains `num_neigh`.
                    if (dp_current[i-1][curr_color][num_neigh] != INF) {
                        dp_current[i][curr_color][num_neigh] = std::min(dp_current[i][curr_color][num_neigh], 
                                                                         dp_current[i-1][curr_color][num_neigh] + cost_to_paint_curr);
                    }

                    // Case 2: Current house `i` is painted with `curr_color`, which is different from `prev_color`
                    // of house `i-1`. A new neighborhood is formed.
                    // So, the number of neighborhoods for houses up to `i-1` must have been `num_neigh - 1`.
                    if (num_neigh > 1) { // A new neighborhood can only be formed if we need more than 1 neighborhood in total.
                        for (int prev_color = 1; prev_color <= n; ++prev_color) {
                            if (prev_color != curr_color) {
                                if (dp_current[i-1][prev_color][num_neigh - 1] != INF) {
                                    dp_current[i][curr_color][num_neigh] = std::min(dp_current[i][curr_color][num_neigh], 
                                                                                     dp_current[i-1][prev_color][num_neigh - 1] + cost_to_paint_curr);
                                }
                            }
                        }
                    }
                }
            }
        }

        // After processing all houses, find the minimum cost among all possible colors for the last house (m-1)
        // that result in exactly `target` neighborhoods.
        long long min_total_cost = INF;
        for (int c = 1; c <= n; ++c) {
            min_total_cost = std::min(min_total_cost, dp_current[m-1][c][target]);
        }

        // If min_total_cost is still INF, it means it's impossible to achieve the target.
        return (min_total_cost == INF) ? -1 : static_cast<int>(min_total_cost);
    }
};