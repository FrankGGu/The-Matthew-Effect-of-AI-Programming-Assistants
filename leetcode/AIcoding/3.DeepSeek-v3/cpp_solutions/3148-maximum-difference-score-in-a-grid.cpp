class Solution {
public:
    int maxScore(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        if (n == 0) return 0;

        vector<vector<int>> dp(m, vector<int>(n, INT_MIN));
        int res = INT_MIN;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == 0 && j == 0) {
                    dp[i][j] = grid[i][j];
                    continue;
                }
                int maxPrev = INT_MIN;
                if (i > 0) maxPrev = max(maxPrev, dp[i-1][j]);
                if (j > 0) maxPrev = max(maxPrev, dp[i][j-1]);
                dp[i][j] = min(grid[i][j], maxPrev);
                res = max(res, grid[i][j] - maxPrev);
            }
        }

        return res;
    }
};