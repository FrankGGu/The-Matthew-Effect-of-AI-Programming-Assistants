class Solution {
public:
    int maximumScore(vector<int>& nums, vector<int>& multipliers) {
        int n = nums.size(), m = multipliers.size();
        vector<vector<int>> dp(m + 1, vector<int>(m + 1, INT_MIN));
        dp[0][0] = 0;

        for (int i = 0; i < m; ++i) {
            for (int left = 0; left <= i; ++left) {
                int right = i - left;
                if (left < n) {
                    dp[i + 1][left + 1] = max(dp[i + 1][left + 1], dp[i][left] + nums[left] * multipliers[i]);
                }
                if (right < n) {
                    dp[i + 1][left] = max(dp[i + 1][left], dp[i][left] + nums[n - 1 - right] * multipliers[i]);
                }
            }
        }

        int maxScore = INT_MIN;
        for (int left = 0; left <= m; ++left) {
            maxScore = max(maxScore, dp[m][left]);
        }

        return maxScore;
    }
};