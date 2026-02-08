class Solution {
public:
    int lengthOfLongestSubsequence(vector<int>& nums, int target) {
        vector<int> dp(target + 1, -1);
        dp[0] = 0;
        for (int num : nums) {
            for (int i = target; i >= num; --i) {
                if (dp[i - num] != -1) {
                    dp[i] = max(dp[i], dp[i - num] + 1);
                }
            }
        }
        return dp[target];
    }
};