class Solution {
public:
    int maxValueOfCoins(vector<vector<int>>& piles, int k) {
        int n = piles.size();
        vector<vector<int>> dp(n + 1, vector<int>(k + 1, 0));

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= k; ++j) {
                int sum = 0;
                dp[i][j] = dp[i - 1][j];
                for (int l = 1; l <= min(j, (int)piles[i - 1].size()); ++l) {
                    sum += piles[i - 1][l - 1];
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - l] + sum);
                }
            }
        }

        return dp[n][k];
    }
};