class Solution {
public:
    int maxSumDivK(vector<int>& nums, int k) {
        int n = nums.size();
        vector<int> dp(k, INT_MIN);
        dp[0] = 0;
        int maxSum = INT_MIN, currentSum = 0;

        for (int i = 0; i < n; ++i) {
            currentSum += nums[i];
            if (i >= k - 1) {
                dp[(i + 1) % k] = max(dp[(i + 1) % k], currentSum);
                if (i >= k) {
                    dp[i % k] = max(dp[i % k], dp[(i + 1 - k) % k] + nums[i]);
                }
                maxSum = max(maxSum, dp[i % k]);
                currentSum -= nums[i + 1 - k];
            }
        }

        return maxSum;
    }
};