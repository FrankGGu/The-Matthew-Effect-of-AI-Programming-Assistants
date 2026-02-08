class Solution {
public:
    int minCost(vector<int>& houses, vector<vector<int>>& cost, int m, int n, int target) {
        const int INF = 1e9;
        vector<vector<vector<int>>> dp(m, vector<vector<int>>(n + 1, vector<int>(target + 1, INF)));

        if (houses[0] == 0) {
            for (int k = 1; k <= n; ++k) {
                dp[0][k][1] = cost[0][k - 1];
            }
        } else {
            dp[0][houses[0]][1] = 0;
        }

        for (int i = 1; i < m; ++i) {
            for (int k = 1; k <= n; ++k) {
                for (int t = 1; t <= target; ++t) {
                    if (houses[i] != 0 && houses[i] != k) {
                        continue;
                    }
                    int current_cost = (houses[i] == k) ? 0 : cost[i][k - 1];
                    int min_prev = INF;
                    for (int prev_k = 1; prev_k <= n; ++prev_k) {
                        if (prev_k == k) {
                            min_prev = min(min_prev, dp[i - 1][prev_k][t]);
                        } else {
                            min_prev = min(min_prev, dp[i - 1][prev_k][t - 1]);
                        }
                    }
                    dp[i][k][t] = min(dp[i][k][t], min_prev + current_cost);
                }
            }
        }

        int result = INF;
        for (int k = 1; k <= n; ++k) {
            result = min(result, dp[m - 1][k][target]);
        }
        return result == INF ? -1 : result;
    }
};