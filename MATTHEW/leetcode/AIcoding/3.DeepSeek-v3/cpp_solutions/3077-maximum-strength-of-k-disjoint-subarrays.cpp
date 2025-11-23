class Solution {
public:
    long long maximumStrength(vector<int>& nums, int k) {
        int n = nums.size();
        vector<vector<long long>> dp(k + 1, vector<long long>(n + 1, LLONG_MIN / 2));
        vector<vector<long long>> max_dp(k + 1, vector<long long>(n + 1, LLONG_MIN / 2));

        for (int i = 0; i <= n; ++i) {
            dp[0][i] = 0;
            max_dp[0][i] = 0;
        }

        for (int i = 1; i <= k; ++i) {
            long long sign = (i % 2 == 1) ? 1 : -1;
            long long weight = sign * (k - i + 1);

            for (int j = 1; j <= n; ++j) {
                dp[i][j] = max(dp[i][j - 1] + weight * nums[j - 1], 
                                max_dp[i - 1][j - 1] + weight * nums[j - 1]);
                max_dp[i][j] = max(max_dp[i][j - 1], dp[i][j]);
            }
        }

        return max_dp[k][n];
    }
};