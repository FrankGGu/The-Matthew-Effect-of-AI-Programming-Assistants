class Solution {
public:
    int minimumTotalDistance(vector<vector<int>>& robot, vector<int>& factory) {
        int n = robot.size(), m = factory.size();
        vector<vector<long long>> dp(n + 1, vector<long long>(m + 1, LLONG_MAX));
        dp[0][0] = 0;

        for (int i = 0; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                long long distance = 0;
                for (int k = i; k <= n; ++k) {
                    if (k == i) distance = 0;
                    distance += abs(factory[j - 1] - (k > 0 ? robot[k - 1][0] : 0));
                    dp[k][j] = min(dp[k][j], dp[i][j - 1] + distance);
                }
            }
        }

        long long minDistance = LLONG_MAX;
        for (int j = 1; j <= m; ++j) {
            minDistance = min(minDistance, dp[n][j]);
        }

        return minDistance == LLONG_MAX ? -1 : minDistance;
    }
};