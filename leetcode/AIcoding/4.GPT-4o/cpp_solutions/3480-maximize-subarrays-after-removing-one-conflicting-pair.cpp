class Solution {
public:
    int maximizeSum(vector<int>& nums, int index) {
        int n = nums.size();
        vector<int> dp(n + 1, 0);
        sort(nums.begin(), nums.end());
        for (int i = 0; i < n; ++i) {
            dp[i + 1] = max(dp[i], dp[i] + nums[i]);
        }
        int maxSum = dp[n];
        if (index > 0) {
            maxSum = max(maxSum, dp[n - 1]);
        }
        return maxSum;
    }
};