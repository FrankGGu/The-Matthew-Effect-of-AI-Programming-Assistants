class Solution {
public:
    int minCost(vector<vector<int>>& costs, int m, int n, int target) {
        const int INF = 1e9;
        vector<vector<int>> dp(m + 1, vector<int>(target + 1, INF));
        dp[0][0] = 0;

        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= target; ++j) {
                for (int k = 0; k < n; ++k) {
                    int cost = costs[i - 1][k];
                    for (int l = 1; l <= n; ++l) {
                        if (j - l >= 0) {
                            dp[i][j] = min(dp[i][j], dp[i - 1][j - l] + cost);
                        }
                    }
                }
            }
        }

        int res = INF;
        for (int j = 1; j <= target; ++j) {
            res = min(res, dp[m][j]);
        }

        return res == INF ? -1 : res;
    }
};