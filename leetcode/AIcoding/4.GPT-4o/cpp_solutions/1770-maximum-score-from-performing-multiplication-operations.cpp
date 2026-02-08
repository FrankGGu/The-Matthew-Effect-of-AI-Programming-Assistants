class Solution {
public:
    int maximumScore(vector<int>& nums, vector<int>& multipliers) {
        int n = nums.size();
        int m = multipliers.size();
        vector<vector<int>> dp(m + 1, vector<int>(m + 1, 0));

        for (int i = 1; i <= m; ++i) {
            for (int j = 0; j <= i; ++j) {
                if (j > 0) {
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - 1] + nums[j - 1] * multipliers[i - 1]);
                }
                if (j < i) {
                    dp[i][j] = max(dp[i][j], dp[i - 1][j] + nums[n - (i - j)] * multipliers[i - 1]);
                }
            }
        }

        int maxScore = 0;
        for (int j = 0; j <= m; ++j) {
            maxScore = max(maxScore, dp[m][j]);
        }

        return maxScore;
    }
};