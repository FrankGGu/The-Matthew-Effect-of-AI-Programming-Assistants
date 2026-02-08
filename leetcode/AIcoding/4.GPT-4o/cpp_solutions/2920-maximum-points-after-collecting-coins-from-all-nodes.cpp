class Solution {
public:
    int maxPoints(vector<vector<int>>& points) {
        int n = points.size();
        int m = points[0].size();
        vector<vector<int>> dp(n, vector<int>(m, 0));

        dp[0][0] = points[0][0];

        for (int i = 1; i < n; i++) {
            dp[i][0] = dp[i - 1][0] + points[i][0];
        }
        for (int j = 1; j < m; j++) {
            dp[0][j] = dp[0][j - 1] + points[0][j];
        }

        for (int i = 1; i < n; i++) {
            for (int j = 1; j < m; j++) {
                dp[i][j] = max(dp[i - 1][j], dp[i][j - 1]) + points[i][j];
            }
        }

        return dp[n - 1][m - 1];
    }
};