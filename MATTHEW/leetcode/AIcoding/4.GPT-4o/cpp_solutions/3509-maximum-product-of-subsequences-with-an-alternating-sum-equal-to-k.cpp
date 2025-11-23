class Solution {
public:
    int maxProduct(vector<int>& nums, int k) {
        int n = nums.size();
        vector<vector<long long>> dp(n + 1, vector<long long>(k + 1, LLONG_MIN));
        dp[0][0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= k; ++j) {
                dp[i][j] = dp[i - 1][j];
                if (j >= nums[i - 1] && dp[i - 1][j - nums[i - 1]] != LLONG_MIN) {
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - nums[i - 1]] * nums[i - 1]);
                }
            }
        }

        long long result = 0;
        for (int j = 0; j <= k; ++j) {
            result = max(result, dp[n][j]);
        }

        return result == LLONG_MIN ? 0 : result;
    }
};