#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minCost(vector<int>& houses, vector<vector<int>>& cost, int m, int n, int target) {
        vector<vector<vector<int>>> dp(m, vector<vector<int>>(target, vector<int>(n, INT_MAX)));

        for (int i = 0; i < n; ++i) {
            if (houses[0] == 0) {
                dp[0][0][i] = cost[0][i];
            } else {
                if (i == houses[0] - 1) {
                    dp[0][0][i] = 0;
                }
            }
        }

        for (int i = 1; i < m; ++i) {
            for (int t = 0; t < target; ++t) {
                for (int j = 0; j < n; ++j) {
                    if (houses[i] != 0) {
                        if (j != houses[i] - 1) continue;
                    }
                    for (int k = 0; k < n; ++k) {
                        if (j == k) continue;
                        if (t > 0 && dp[i-1][t-1][k] != INT_MAX) {
                            dp[i][t][j] = min(dp[i][t][j], dp[i-1][t-1][k] + (houses[i] == 0 ? cost[i][j] : 0));
                        }
                    }
                }
            }
        }

        int result = INT_MAX;
        for (int i = 0; i < n; ++i) {
            result = min(result, dp[m-1][target-1][i]);
        }

        return result;
    }
};