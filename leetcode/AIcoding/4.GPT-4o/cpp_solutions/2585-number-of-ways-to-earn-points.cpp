class Solution {
public:
    int waysToEarnPoints(vector<int>& points) {
        int n = points.size();
        vector<long long> dp(10001, 0);
        dp[0] = 1;

        for (int i = 0; i < n; ++i) {
            for (int j = 10000; j >= points[i]; --j) {
                dp[j] = (dp[j] + dp[j - points[i]]) % 1000000007;
            }
        }

        long long totalWays = 0;
        for (int j = 0; j <= 10000; ++j) {
            totalWays = (totalWays + dp[j]) % 1000000007;
        }

        return totalWays;
    }
};