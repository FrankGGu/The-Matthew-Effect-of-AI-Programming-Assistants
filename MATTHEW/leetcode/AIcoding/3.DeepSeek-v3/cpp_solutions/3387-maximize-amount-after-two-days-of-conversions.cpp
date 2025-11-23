class Solution {
public:
    int maximumAmount(vector<int>& nums, int k) {
        int n = nums.size();
        if (n == 0 || k == 0) return 0;

        vector<vector<int>> dp(n, vector<int>(k + 1, 0));
        dp[0][0] = nums[0];
        for (int j = 1; j <= k; ++j) {
            dp[0][j] = nums[0] / 2;
        }

        for (int i = 1; i < n; ++i) {
            dp[i][0] = dp[i-1][0] + nums[i];
            for (int j = 1; j <= k; ++j) {
                dp[i][j] = max(dp[i-1][j] + nums[i], dp[i-1][j-1] + nums[i] / 2);
            }
        }

        return dp[n-1][k];
    }
};