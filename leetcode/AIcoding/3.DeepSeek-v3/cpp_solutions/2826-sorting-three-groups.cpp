class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        int n = nums.size();
        vector<vector<int>> dp(n + 1, vector<int>(4, INT_MAX));
        dp[0][1] = dp[0][2] = dp[0][3] = 0;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= 3; ++j) {
                for (int k = 1; k <= j; ++k) {
                    if (dp[i-1][k] != INT_MAX) {
                        int cost = (nums[i-1] != j) ? 1 : 0;
                        dp[i][j] = min(dp[i][j], dp[i-1][k] + cost);
                    }
                }
            }
        }

        return min({dp[n][1], dp[n][2], dp[n][3]});
    }
};