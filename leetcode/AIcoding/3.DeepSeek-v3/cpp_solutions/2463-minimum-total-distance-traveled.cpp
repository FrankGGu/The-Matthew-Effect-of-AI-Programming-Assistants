class Solution {
public:
    long long minimumTotalDistance(vector<int>& robot, vector<vector<int>>& factory) {
        sort(robot.begin(), robot.end());
        sort(factory.begin(), factory.end());
        int m = robot.size();
        int n = factory.size();
        vector<vector<long long>> dp(n + 1, vector<long long>(m + 1, LLONG_MAX / 2));
        dp[0][0] = 0;
        for (int i = 1; i <= n; ++i) {
            int pos = factory[i - 1][0];
            int limit = factory[i - 1][1];
            dp[i][0] = 0;
            for (int j = 1; j <= m; ++j) {
                long long cost = 0;
                dp[i][j] = dp[i - 1][j];
                for (int k = 1; k <= min(limit, j); ++k) {
                    cost += abs(pos - robot[j - k]);
                    if (dp[i - 1][j - k] + cost < dp[i][j]) {
                        dp[i][j] = dp[i - 1][j - k] + cost;
                    }
                }
            }
        }
        return dp[n][m];
    }
};