class Solution {
public:
    long long maxScore(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        if (n == 0) return 0;

        vector<vector<long long>> dp(m, vector<long long>(n, LLONG_MIN));
        long long maxScore = LLONG_MIN;

        for (int i = m - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                long long currentMax = LLONG_MIN;
                if (i + 1 < m) {
                    currentMax = max(currentMax, dp[i + 1][j]);
                }
                if (j + 1 < n) {
                    currentMax = max(currentMax, dp[i][j + 1]);
                }
                if (currentMax != LLONG_MIN) {
                    dp[i][j] = max(grid[i][j] - currentMax, currentMax);
                } else {
                    dp[i][j] = grid[i][j];
                }
                maxScore = max(maxScore, dp[i][j]);
            }
        }

        return maxScore;
    }
};