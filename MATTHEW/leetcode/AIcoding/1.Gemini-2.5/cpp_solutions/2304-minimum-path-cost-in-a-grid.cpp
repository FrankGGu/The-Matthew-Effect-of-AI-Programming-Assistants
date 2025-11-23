#include <vector>
#include <algorithm> // For std::min
#include <limits>    // For std::numeric_limits

class Solution {
public:
    int minPathCost(std::vector<std::vector<int>>& grid, std::vector<std::vector<int>>& moveCost) {
        int m = grid.size();
        int n = grid[0].size();

        // dp[i][j] will store the minimum total cost of a path from any cell in the first row
        // to cell (i, j). The total cost is defined as the sum of all "move costs" along the path.
        // A "move cost" from cell (r, c) to cell (r+1, next_c) is given by
        // grid[r][c] + moveCost[grid[r][c]][next_c].
        std::vector<std::vector<int>> dp(m, std::vector<int>(n));

        // Initialize the first row of dp.
        // To reach a cell in the first row, no moves have been made yet.
        // Thus, the accumulated "move cost" sum is 0.
        // The values grid[0][j] will be incorporated into the first move's cost
        // when calculating dp[1][...].
        for (int j = 0; j < n; ++j) {
            dp[0][j] = 0; 
        }

        // Fill the dp table for subsequent rows
        for (int i = 1; i < m; ++i) { // Iterate through target rows (from 1 to m-1)
            for (int j = 0; j < n; ++j) { // Iterate through columns in the current target row
                dp[i][j] = std::numeric_limits<int>::max(); // Initialize with a large value (infinity)

                // Iterate over all possible previous columns in row i-1 (source cells for the move)
                for (int prev_j = 0; prev_j < n; ++prev_j) {
                    // Get the value of the cell we are moving *from*
                    int value_in_prev_cell = grid[i-1][prev_j];

                    // Calculate the cost of the current move:
                    // grid[i-1][prev_j] + moveCost[value_in_prev_cell][j]
                    int current_move_cost = value_in_prev_cell + moveCost[value_in_prev_cell][j];

                    // Update dp[i][j] with the minimum total move cost to reach it.
                    // This is the sum of the minimum move costs to reach (i-1, prev_j)
                    // plus the cost of the current move to (i, j).
                    dp[i][j] = std::min(dp[i][j], dp[i-1][prev_j] + current_move_cost);
                }
            }
        }

        // The final answer is the minimum total move cost to reach any cell in the last row (m-1).
        int min_total_cost = std::numeric_limits<int>::max();
        for (int j = 0; j < n; ++j) {
            min_total_cost = std::min(min_total_cost, dp[m-1][j]);
        }

        return min_total_cost;
    }
};