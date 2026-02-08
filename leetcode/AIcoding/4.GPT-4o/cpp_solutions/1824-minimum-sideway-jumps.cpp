class Solution {
public:
    int minSideJumps(vector<int>& obstacles) {
        int n = obstacles.size();
        vector<vector<int>> dp(n, vector<int>(4, INT_MAX));
        dp[0][1] = 0; // Starting on lane 1

        for (int i = 0; i < n; ++i) {
            for (int j = 1; j <= 3; ++j) {
                if (obstacles[i] != j) {
                    dp[i][j] = min(dp[i][j], dp[i][j]);
                    if (i < n - 1) dp[i + 1][j] = min(dp[i + 1][j], dp[i][j]);
                }
            }
            for (int j = 1; j <= 3; ++j) {
                if (obstacles[i] != j) {
                    for (int k = 1; k <= 3; ++k) {
                        if (j != k && obstacles[i] != k) {
                            dp[i][k] = min(dp[i][k], dp[i][j] + 1);
                        }
                    }
                }
            }
        }
        return min({dp[n - 1][1], dp[n - 1][2], dp[n - 1][3]});
    }
};