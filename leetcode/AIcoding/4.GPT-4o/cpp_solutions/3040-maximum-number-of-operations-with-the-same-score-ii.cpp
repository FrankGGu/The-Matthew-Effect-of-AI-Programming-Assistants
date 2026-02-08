class Solution {
public:
    int maximumScore(vector<int>& nums, vector<int>& multipliers) {
        int n = nums.size(), m = multipliers.size();
        vector<vector<int>> dp(m + 1, vector<int>(m + 1, INT_MIN));
        dp[0][0] = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j <= i; ++j) {
                int left = dp[i][j] + nums[j] * multipliers[i];
                int right = dp[i][j] + nums[n - 1 - (i - j)] * multipliers[i];
                dp[i + 1][j] = max(dp[i + 1][j], left);
                dp[i + 1][j + 1] = max(dp[i + 1][j + 1], right);
            }
        }

        int maxScore = INT_MIN;
        for (int j = 0; j <= m; ++j) {
            maxScore = max(maxScore, dp[m][j]);
        }

        return maxScore;
    }
};