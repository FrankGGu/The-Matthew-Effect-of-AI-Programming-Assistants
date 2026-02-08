#include <vector>
#include <algorithm>

class Solution {
public:
    int maxMoves(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        std::vector<std::vector<int>> dp(m, std::vector<int>(n, -1));
        for (int i = 0; i < m; ++i) {
            dp[i][0] = 0;
        }

        int max_moves = 0;

        for (int j = 1; j < n; ++j) {
            for (int i = 0; i < m; ++i) {
                // From (i-1, j-1)
                if (i > 0 && dp[i - 1][j - 1] != -1 && grid[i][j] > grid[i - 1][j - 1]) {
                    dp[i][j] = std::max(dp[i][j], dp[i - 1][j - 1] + 1);
                }
                // From (i, j-1)
                if (dp[i][j - 1] != -1 && grid[i][j] > grid[i][j - 1]) {
                    dp[i][j] = std::max(dp[i][j], dp[i][j - 1] + 1);
                }
                // From (i+1, j-1)
                if (i < m - 1 && dp[i + 1][j - 1] != -1 && grid[i][j] > grid[i + 1][j - 1]) {
                    dp[i][j] = std::max(dp[i][j], dp[i + 1][j - 1] + 1);
                }
                max_moves = std::max(max_moves, dp[i][j]);
            }
        }

        return max_moves;
    }
};