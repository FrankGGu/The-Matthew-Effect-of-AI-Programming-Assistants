class Solution {
public:
    int minNumberGame(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n);
        dp[0] = nums[0];
        for (int i = 1; i < n; i += 2) {
            if (i + 1 < n) {
                dp[i] = min(dp[i - 1], nums[i]) + nums[i + 1];
                if (i > 1) dp[i] = min(dp[i], dp[i - 2]);
            } else {
                dp[i] = min(dp[i - 1], nums[i]);
            }
        }
        return dp[n - 1];
    }
};