class Solution {
public:
    int minDistance(vector<int>& houses, int m) {
        int n = houses.size();
        vector<vector<int>> dp(n + 1, vector<int>(m + 1, INT_MAX));
        vector<int> prefixSum(n + 1, 0);

        sort(houses.begin(), houses.end());

        for (int i = 1; i <= n; ++i) {
            prefixSum[i] = prefixSum[i - 1] + houses[i - 1];
        }

        for (int i = 0; i <= n; ++i) {
            dp[i][0] = (i == 0) ? 0 : INT_MAX;
        }

        for (int j = 1; j <= m; ++j) {
            for (int i = j; i <= n; ++i) {
                for (int k = j - 1; k < i; ++k) {
                    int distance = (houses[i - 1] - houses[k]) * (houses[i - 1] - houses[k]) + (prefixSum[k + 1] - prefixSum[j - 1]);
                    dp[i][j] = min(dp[i][j], dp[k][j - 1] + distance);
                }
            }
        }

        return dp[n][m];
    }
};