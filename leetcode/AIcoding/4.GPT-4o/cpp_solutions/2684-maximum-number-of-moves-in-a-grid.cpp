class Solution {
public:
    int maxMoves(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> dp(m, vector<int>(n, 0));
        int maxMoves = 0;

        for (int j = 0; j < n; ++j) {
            dp[0][j] = 1;
        }

        for (int i = 1; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (j > 0 && grid[i][j] > grid[i - 1][j - 1]) {
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - 1] + 1);
                }
                if (grid[i][j] > grid[i - 1][j]) {
                    dp[i][j] = max(dp[i][j], dp[i - 1][j] + 1);
                }
                if (j < n - 1 && grid[i][j] > grid[i - 1][j + 1]) {
                    dp[i][j] = max(dp[i][j], dp[i - 1][j + 1] + 1);
                }
            }
        }

        for (int j = 0; j < n; ++j) {
            maxMoves = max(maxMoves, dp[m - 1][j]);
        }

        return maxMoves;
    }
};