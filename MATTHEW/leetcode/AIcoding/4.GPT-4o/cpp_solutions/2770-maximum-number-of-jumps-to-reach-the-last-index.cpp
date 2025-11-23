class Solution {
public:
    int maxJumps(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n, 0);
        dp[0] = 0;
        for (int i = 1; i < n; ++i) {
            dp[i] = INT_MIN;
            for (int j = 0; j < i; ++j) {
                if (j + nums[j] >= i) {
                    dp[i] = max(dp[i], dp[j] + 1);
                }
            }
        }
        return dp[n - 1];
    }
};