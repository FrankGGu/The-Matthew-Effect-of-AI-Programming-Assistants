class Solution {
public:
    int maxProductPath(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<long long>> max_dp(m, vector<long long>(n));
        vector<vector<long long>> min_dp(m, vector<long long>(n));

        max_dp[0][0] = min_dp[0][0] = grid[0][0];

        for (int i = 1; i < m; ++i) {
            max_dp[i][0] = min_dp[i][0] = max_dp[i-1][0] * grid[i][0];
        }
        for (int j = 1; j < n; ++j) {
            max_dp[0][j] = min_dp[0][j] = max_dp[0][j-1] * grid[0][j];
        }

        for (int i = 1; i < m; ++i) {
            for (int j = 1; j < n; ++j) {
                if (grid[i][j] > 0) {
                    max_dp[i][j] = max(max_dp[i-1][j], max_dp[i][j-1]) * grid[i][j];
                    min_dp[i][j] = min(min_dp[i-1][j], min_dp[i][j-1]) * grid[i][j];
                } else {
                    max_dp[i][j] = min(min_dp[i-1][j], min_dp[i][j-1]) * grid[i][j];
                    min_dp[i][j] = max(max_dp[i-1][j], max_dp[i][j-1]) * grid[i][j];
                }
            }
        }

        if (max_dp[m-1][n-1] < 0) return -1;
        return max_dp[m-1][n-1] % (1000000007);
    }
};