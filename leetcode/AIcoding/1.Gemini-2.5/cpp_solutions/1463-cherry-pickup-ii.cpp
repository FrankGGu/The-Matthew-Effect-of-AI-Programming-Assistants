#include <vector>
#include <algorithm>

class Solution {
public:
    int cherryPickup(std::vector<std::vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();

        std::vector<std::vector<std::vector<int>>> dp(rows, std::vector<std::vector<int>>(cols, std::vector<int>(cols, -1)));

        // Base case: Last row (rows-1)
        for (int c1 = 0; c1 < cols; ++c1) {
            for (int c2 = 0; c2 < cols; ++c2) {
                dp[rows - 1][c1][c2] = grid[rows - 1][c1] + (c1 == c2 ? 0 : grid[rows - 1][c2]);
            }
        }

        // Iterate from the second to last row up to the first row
        for (int r = rows - 2; r >= 0; --r) {
            for (int c1 = 0; c1 < cols; ++c1) {
                for (int c2 = 0; c2 < cols; ++c2) {
                    int current_cherries = grid[r][c1] + (c1 == c2 ? 0 : grid[r][c2]);

                    int max_next_row_cherries = -1;

                    for (int dc1 = -1; dc1 <= 1; ++dc1) {
                        int nc1 = c1 + dc1;
                        for (int dc2 = -1; dc2 <= 1; ++dc2) {
                            int nc2 = c2 + dc2;

                            if (nc1 >= 0 && nc1 < cols && nc2 >= 0 && nc2 < cols) {
                                if (dp[r + 1][nc1][nc2] != -1) {
                                    max_next_row_cherries = std::max(max_next_row_cherries, dp[r + 1][nc1][nc2]);
                                }
                            }
                        }
                    }

                    if (max_next_row_cherries != -1) {
                        dp[r][c1][c2] = current_cherries + max_next_row_cherries;
                    }
                }
            }
        }

        return dp[0][0][cols - 1];
    }
};