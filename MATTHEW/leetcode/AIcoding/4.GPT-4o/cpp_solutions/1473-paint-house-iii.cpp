class Solution {
public:
    int minCost(vector<vector<int>>& costs, int m, int n, int target) {
        vector<vector<vector<int>>> dp(m + 1, vector<vector<int>>(n + 1, vector<int>(target + 1, INT_MAX)));
        dp[0][0][0] = 0;

        for (int i = 1; i <= m; ++i) {
            for (int j = 1; j <= n; ++j) {
                for (int k = 1; k <= target; ++k) {
                    for (int color = 0; color < n; ++color) {
                        int cost = costs[i - 1][color];
                        for (int prevColor = 0; prevColor < n; ++prevColor) {
                            int add = (color == prevColor) ? 0 : 1;
                            if (dp[i - 1][j - 1][k - add] != INT_MAX) {
                                dp[i][j][k] = min(dp[i][j][k], dp[i - 1][j - 1][k - add] + cost);
                            }
                        }
                    }
                }
            }
        }

        int result = INT_MAX;
        for (int j = 1; j <= n; ++j) {
            result = min(result, dp[m][j][target]);
        }

        return result == INT_MAX ? -1 : result;
    }
};