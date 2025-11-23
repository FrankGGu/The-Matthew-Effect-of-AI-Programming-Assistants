class Solution {
public:
    int longestSubsequence(vector<int>& nums, int target) {
        int n = nums.size();
        vector<int> dp(target + 1, 0);

        for (int num : nums) {
            for (int j = target; j >= num; j--) {
                dp[j] = max(dp[j], dp[j - num] + 1);
            }
        }

        return dp[target];
    }
};