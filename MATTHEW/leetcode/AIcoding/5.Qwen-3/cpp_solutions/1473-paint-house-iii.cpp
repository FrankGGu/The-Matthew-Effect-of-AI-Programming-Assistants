#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int minCost(vector<int>& houses, vector<vector<int>>& cost, int m, int n, int k) {
        vector<vector<vector<int>>> dp(m, vector<vector<int>>(n, vector<int>(k, INT_MAX)));
        for (int j = 0; j < n; ++j) {
            dp[0][j][0] = cost[0][j];
        }
        for (int i = 1; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (houses[i] != 0) {
                    int color = houses[i] - 1;
                    for (int prev_color = 0; prev_color < n; ++prev_color) {
                        if (prev_color == color) continue;
                        for (int t = 0; t < k; ++t) {
                            if (dp[i-1][prev_color][t] != INT_MAX) {
                                dp[i][color][t+1] = min(dp[i][color][t+1], dp[i-1][prev_color][t]);
                            }
                        }
                    }
                } else {
                    for (int color = 0; color < n; ++color) {
                        for (int prev_color = 0; prev_color < n; ++prev_color) {
                            if (prev_color == color) continue;
                            for (int t = 0; t < k; ++t) {
                                if (dp[i-1][prev_color][t] != INT_MAX) {
                                    dp[i][color][t+1] = min(dp[i][color][t+1], dp[i-1][prev_color][t] + cost[i][color]);
                                }
                            }
                        }
                    }
                }
            }
        }
        int result = INT_MAX;
        for (int j = 0; j < n; ++j) {
            result = min(result, dp[m-1][j][k-1]);
        }
        return result;
    }
};