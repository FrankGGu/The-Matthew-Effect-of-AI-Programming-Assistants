class Solution {
public:
    int maxPoints(vector<vector<int>>& points) {
        int n = points.size();
        if (n == 0) return 0;
        int m = points[0].size();
        vector<vector<int>> dp(n, vector<int>(m, 0));

        for (int j = 0; j < m; j++) {
            dp[0][j] = points[0][j];
        }

        for (int i = 1; i < n; i++) {
            vector<int> left(m), right(m);
            left[0] = dp[i-1][0];
            for (int j = 1; j < m; j++) {
                left[j] = max(left[j-1] - 1, dp[i-1][j]);
            }
            right[m-1] = dp[i-1][m-1];
            for (int j = m-2; j >= 0; j--) {
                right[j] = max(right[j+1] - 1, dp[i-1][j]);
            }
            for (int j = 0; j < m; j++) {
                dp[i][j] = points[i][j] + max(left[j], right[j]);
            }
        }

        int maxPoints = 0;
        for (int j = 0; j < m; j++) {
            maxPoints = max(maxPoints, dp[n-1][j]);
        }

        return maxPoints;
    }
};