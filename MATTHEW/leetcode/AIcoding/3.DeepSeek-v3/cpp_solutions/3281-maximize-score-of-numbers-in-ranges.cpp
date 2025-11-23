class Solution {
public:
    int maxScore(vector<int>& nums, vector<vector<int>>& ranges) {
        int n = nums.size();
        vector<vector<int>> dp(n, vector<int>(n, 0));

        for (int len = 1; len <= n; ++len) {
            for (int i = 0; i + len <= n; ++i) {
                int j = i + len - 1;
                for (const auto& range : ranges) {
                    int l = range[0], r = range[1];
                    if (i <= l && r <= j) {
                        int sum = nums[l] + nums[r];
                        int left = (l > i) ? dp[i][l - 1] : 0;
                        int right = (r < j) ? dp[r + 1][j] : 0;
                        dp[i][j] = max(dp[i][j], left + sum + right);
                    }
                }
                if (dp[i][j] == 0) {
                    dp[i][j] = (i == j) ? nums[i] : 0;
                }
            }
        }

        return dp[0][n - 1];
    }
};