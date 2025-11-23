class Solution {
public:
    int kSum(vector<int>& nums, int k) {
        int n = nums.size();
        sort(nums.begin(), nums.end());
        vector<vector<int>> dp(k + 1, vector<int>(n + 1, 0));
        dp[0][0] = 1;

        for (int j = 1; j <= n; ++j) {
            for (int i = 0; i <= k; ++i) {
                dp[i][j] = dp[i][j - 1];
                if (i >= nums[j - 1]) {
                    dp[i][j] += dp[i - nums[j - 1]][j - 1];
                }
            }
        }
        return dp[k][n];
    }
};