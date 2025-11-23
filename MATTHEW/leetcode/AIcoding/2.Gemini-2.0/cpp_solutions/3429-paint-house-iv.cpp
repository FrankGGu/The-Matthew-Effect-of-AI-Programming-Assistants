#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCostII(vector<vector<int>>& costs, int n, int k) {
        if (n == 0) return 0;
        if (k == 1) {
            if (n == 1) return costs[0][0];
            else return -1;
        }

        vector<vector<int>> dp(n, vector<int>(k, 0));

        for (int j = 0; j < k; ++j) {
            dp[0][j] = costs[0][j];
        }

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < k; ++j) {
                int min_cost = INT_MAX;
                for (int l = 0; l < k; ++l) {
                    if (l != j) {
                        min_cost = min(min_cost, dp[i - 1][l]);
                    }
                }
                dp[i][j] = min_cost + costs[i][j];
            }
        }

        int min_total_cost = INT_MAX;
        for (int j = 0; j < k; ++j) {
            min_total_cost = min(min_total_cost, dp[n - 1][j]);
        }

        return min_total_cost;
    }
};