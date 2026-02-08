class Solution {
public:
    int countWays(vector<vector<int>>& ranges) {
        const int MOD = 1e9 + 7;
        int n = ranges.size();
        vector<long long> dp(n + 1, 0);
        dp[0] = 1;

        sort(ranges.begin(), ranges.end());

        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1];
            for (int j = 0; j < i; ++j) {
                if (ranges[j][1] < ranges[i - 1][0]) {
                    dp[i] = (dp[i] + dp[j + 1]) % MOD;
                }
            }
        }
        return dp[n];
    }
};