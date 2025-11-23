#include <vector>
#include <algorithm> // Required for std::min

class Solution {
public:
    int minimumOperations(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        // cost[j][val] stores the number of operations required to make all cells
        // in column j equal to 'val'.
        std::vector<std::vector<int>> cost(n, std::vector<int>(10, 0));

        for (int j = 0; j < n; ++j) {
            for (int val = 0; val <= 9; ++val) {
                for (int i = 0; i < m; ++i) {
                    if (grid[i][j] != val) {
                        cost[j][val]++;
                    }
                }
            }
        }

        // dp[j][val] stores the minimum operations to satisfy conditions for columns
        // 0 to j, with column j having all cells set to 'val'.
        // Initialize with a large value representing infinity.
        const int INF = 1e9; 
        std::vector<std::vector<int>> dp(n, std::vector<int>(10, INF));

        // Base case: For the first column (j = 0)
        // The cost is simply the operations needed to set all cells in column 0 to 'val'.
        for (int val = 0; val <= 9; ++val) {
            dp[0][val] = cost[0][val];
        }

        // Fill the dp table for subsequent columns
        for (int j = 1; j < n; ++j) {
            for (int current_val = 0; current_val <= 9; ++current_val) {
                for (int prev_val = 0; prev_val <= 9; ++prev_val) {
                    // Condition: The value in the current column must be different
                    // from the value in the previous column.
                    if (current_val != prev_val) {
                        dp[j][current_val] = std::min(dp[j][current_val], dp[j-1][prev_val] + cost[j][current_val]);
                    }
                }
            }
        }

        // The final answer is the minimum value in the last column of the dp table.
        int min_ops = INF;
        for (int val = 0; val <= 9; ++val) {
            min_ops = std::min(min_ops, dp[n-1][val]);
        }

        return min_ops;
    }
};