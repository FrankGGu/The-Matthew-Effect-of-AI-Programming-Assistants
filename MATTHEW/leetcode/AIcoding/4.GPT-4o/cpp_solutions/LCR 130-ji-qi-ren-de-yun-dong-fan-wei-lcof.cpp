class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[j] <= nums[i - 1]) {
                    dp[i] = min(dp[i], dp[j] + (i - j - 1));
                }
            }
        }

        return n - *max_element(dp.begin(), dp.end());
    }
};