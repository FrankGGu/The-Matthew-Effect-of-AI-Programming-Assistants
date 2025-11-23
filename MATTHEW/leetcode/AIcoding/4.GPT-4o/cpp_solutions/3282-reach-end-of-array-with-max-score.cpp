class Solution {
public:
    long long maxScore(vector<int>& nums) {
        int n = nums.size();
        vector<long long> dp(n + 1, 0);
        dp[0] = 0;
        long long sum = 0;

        for (int i = 0; i < n; ++i) {
            sum += nums[i];
            for (int j = i + 1; j >= 1; --j) {
                dp[j] = max(dp[j], dp[j - 1] + sum);
            }
        }

        return dp[n];
    }
};