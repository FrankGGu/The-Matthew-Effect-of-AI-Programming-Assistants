class Solution {
public:
    long long maximumAmount(vector<int>& A) {
        int n = A.size();
        vector<vector<long long>> dp(n + 1, vector<long long>(2, 0));

        for (int i = 1; i <= n; ++i) {
            dp[i][0] = dp[i - 1][0];
            dp[i][1] = dp[i - 1][1];
            if (i % 2 == 1) {
                dp[i][0] = max(dp[i][0], dp[i - 1][1] + A[i - 1]);
            } else {
                dp[i][1] = max(dp[i][1], dp[i - 1][0] + A[i - 1]);
            }
        }

        return max(dp[n][0], dp[n][1]);
    }
};