class Solution {
public:
    double largestSumOfAverages(vector<int>& nums, int k) {
        int n = nums.size();
        vector<double> prefix(n + 1, 0.0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        vector<vector<double>> dp(n + 1, vector<double>(k + 1, 0.0));
        for (int i = 1; i <= n; ++i) {
            dp[i][1] = prefix[i] / i;
        }

        for (int j = 2; j <= k; ++j) {
            for (int i = j; i <= n; ++i) {
                for (int m = j - 1; m < i; ++m) {
                    dp[i][j] = max(dp[i][j], dp[m][j - 1] + (prefix[i] - prefix[m]) / (i - m));
                }
            }
        }

        return dp[n][k];
    }
};