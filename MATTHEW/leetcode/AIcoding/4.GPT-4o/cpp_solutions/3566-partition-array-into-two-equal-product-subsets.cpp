class Solution {
public:
    bool canPartition(vector<int>& nums) {
        int product = 1;
        for (int num : nums) {
            product *= num;
        }
        if (product % 2 != 0) return false;
        product /= 2;

        int n = nums.size();
        vector<vector<bool>> dp(n + 1, vector<bool>(product + 1, false));
        dp[0][0] = true;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= product; ++j) {
                dp[i][j] = dp[i - 1][j];
                if (j >= nums[i - 1]) {
                    dp[i][j] = dp[i][j] || dp[i - 1][j / nums[i - 1]];
                }
            }
        }

        return dp[n][product];
    }
};