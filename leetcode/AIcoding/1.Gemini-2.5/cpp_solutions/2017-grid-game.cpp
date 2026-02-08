#include <vector>
#include <numeric>
#include <algorithm>
#include <limits>

class Solution {
public:
    long long gridGame(std::vector<std::vector<int>>& grid) {
        int n = grid[0].size();

        long long top_row_sum = 0;
        for (int val : grid[0]) {
            top_row_sum += val;
        }

        long long bottom_row_prefix_sum = 0;
        long long min_robot2_score = std::numeric_limits<long long>::max();

        for (int i = 0; i < n; ++i) {
            // When Robot 1 makes its down move at column i:
            // It collects grid[0][0...i] and grid[1][i...N-1].
            // These cells are set to zero.

            // The points remaining for Robot 2 in the top row are grid[0][i+1...N-1].
            // We subtract grid[0][i] from top_row_sum to get this value.
            top_row_sum -= grid[0][i];

            // The points remaining for Robot 2 in the bottom row are grid[1][0...i-1].
            // 'bottom_row_prefix_sum' already holds this value from previous iterations.

            // Robot 2 will choose a path to maximize its score, which means it will collect
            // either all remaining points in the top row (grid[0][i+1...N-1])
            // or all remaining points in the bottom row (grid[1][0...i-1]).
            long long current_robot2_score = std::max(top_row_sum, bottom_row_prefix_sum);

            // Robot 1 wants to minimize Robot 2's maximum possible score.
            min_robot2_score = std::min(min_robot2_score, current_robot2_score);

            // For the next iteration (i+1), grid[1][i] will be included in the
            // 'bottom_row_prefix_sum' for the new 'i'.
            bottom_row_prefix_sum += grid[1][i];
        }

        return min_robot2_score;
    }
};