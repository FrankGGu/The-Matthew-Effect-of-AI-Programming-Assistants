class Solution {
public:
    long long maxScore(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<long long>> dp(m, vector<long long>(n, LLONG_MIN));
        dp[m-1][n-1] = 0;
        long long res = LLONG_MIN;

        for (int i = m-1; i >= 0; --i) {
            for (int j = n-1; j >= 0; --j) {
                if (i == m-1 && j == n-1) continue;
                long long max_val = LLONG_MIN;
                if (i + 1 < m) {
                    max_val = max(max_val, dp[i+1][j]);
                }
                if (j + 1 < n) {
                    max_val = max(max_val, dp[i][j+1]);
                }
                dp[i][j] = max_val + grid[i][j];
                res = max(res, max_val - grid[i][j]);
            }
        }

        return res;
    }
};