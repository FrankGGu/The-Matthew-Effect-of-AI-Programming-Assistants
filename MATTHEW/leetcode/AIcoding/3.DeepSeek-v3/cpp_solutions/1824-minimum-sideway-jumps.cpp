class Solution {
public:
    int minSideJumps(vector<int>& obstacles) {
        int n = obstacles.size();
        vector<vector<int>> dp(n, vector<int>(3, INT_MAX));
        dp[0][0] = 1;
        dp[0][1] = 0;
        dp[0][2] = 1;

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < 3; ++j) {
                if (obstacles[i] == j + 1) {
                    dp[i][j] = INT_MAX;
                } else {
                    int min_val = dp[i-1][j];
                    for (int k = 0; k < 3; ++k) {
                        if (k != j && obstacles[i] != k + 1) {
                            min_val = min(min_val, dp[i-1][k] + 1);
                        }
                    }
                    dp[i][j] = min_val;
                }
            }
        }

        return min(dp[n-1][0], min(dp[n-1][1], dp[n-1][2]));
    }
};