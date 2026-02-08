class Solution {
public:
    int countPaths(vector<vector<int>>& grid, int k) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<vector<int>>> dp(m, vector<vector<int>>(n, vector<int>(k, 0)));
        dp[0][0][grid[0][0] % k] = 1;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                for (int mod = 0; mod < k; ++mod) {
                    if (i > 0) {
                        dp[i][j][(mod + grid[i][j]) % k] += dp[i - 1][j][mod];
                    }
                    if (j > 0) {
                        dp[i][j][(mod + grid[i][j]) % k] += dp[i][j - 1][mod];
                    }
                }
            }
        }

        return dp[m - 1][n - 1][0];
    }
};