class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = n; j > 0; j--) {
                if (j > 0 && dp[j - 1] != INT_MAX) {
                    dp[j] = min(dp[j], dp[j - 1] + (nums[i] != j));
                }
            }
        }

        for (int j = n; j >= 0; j--) {
            if (dp[j] != INT_MAX) {
                return dp[j];
            }
        }

        return 0;
    }
};