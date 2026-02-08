class Solution {
public:
    int guardCastle(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> dp(m, vector<int>(n, 0));

        for (int i = m - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                if (grid[i][j] == 1) {
                    dp[i][j] = 1;
                } else {
                    if (i + 1 < m) dp[i][j] += dp[i + 1][j];
                    if (j + 1 < n) dp[i][j] += dp[i][j + 1];
                }
            }
        }

        return dp[0][0];
    }
};