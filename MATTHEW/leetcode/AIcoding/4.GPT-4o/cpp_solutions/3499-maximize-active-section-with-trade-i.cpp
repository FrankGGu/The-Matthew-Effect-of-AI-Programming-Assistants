class Solution {
public:
    int maximizeGain(vector<int>& nums, int gain, int k) {
        int n = nums.size();
        vector<long long> dp(n + 1, 0);
        sort(nums.begin(), nums.end());

        for (int i = 1; i <= n; i++) {
            dp[i] = max(dp[i - 1], dp[max(0, i - k - 1)] + nums[i - 1] + gain);
        }

        return dp[n];
    }
};