class Solution {
public:
    int findPaths(int m, int n, int maxMove, int startRow, int startColumn) {
        const int MOD = 1e9 + 7;
        vector<vector<vector<int>>> dp(m, vector<vector<int>>(n, vector<int>(maxMove + 1, 0)));

        for (int move = 1; move <= maxMove; ++move) {
            for (int row = 0; row < m; ++row) {
                for (int col = 0; col < n; ++col) {
                    if (row == 0) dp[row][col][move] = (dp[row][col][move] + 1) % MOD;
                    if (row == m - 1) dp[row][col][move] = (dp[row][col][move] + 1) % MOD;
                    if (col == 0) dp[row][col][move] = (dp[row][col][move] + 1) % MOD;
                    if (col == n - 1) dp[row][col][move] = (dp[row][col][move] + 1) % MOD;

                    if (row > 0) dp[row][col][move] = (dp[row][col][move] + dp[row - 1][col][move - 1]) % MOD;
                    if (row < m - 1) dp[row][col][move] = (dp[row][col][move] + dp[row + 1][col][move - 1]) % MOD;
                    if (col > 0) dp[row][col][move] = (dp[row][col][move] + dp[row][col - 1][move - 1]) % MOD;
                    if (col < n - 1) dp[row][col][move] = (dp[row][col][move] + dp[row][col + 1][move - 1]) % MOD;
                }
            }
        }

        int result = 0;
        for (int move = 1; move <= maxMove; ++move) {
            result = (result + dp[startRow][startColumn][move]) % MOD;
        }

        return result;
    }
};