#include <iostream>
#include <vector>
#include <climits>
#include <algorithm>

using namespace std;

class Solution {
public:
    int connectTwoGroups(vector<vector<int>>& cost) {
        int n = cost.size();
        int m = cost[0].size();
        vector<vector<int>> dp(1 << m, vector<int>(m, INT_MAX));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (cost[i][j] == 0) continue;
                for (int mask = 0; mask < (1 << m); ++mask) {
                    int new_mask = mask | (1 << j);
                    dp[new_mask][j] = min(dp[new_mask][j], dp[mask][j] + cost[i][j]);
                }
            }
        }

        int result = INT_MAX;
        for (int mask = 0; mask < (1 << m); ++mask) {
            int total = 0;
            for (int j = 0; j < m; ++j) {
                if ((mask & (1 << j)) == 0) {
                    int min_cost = INT_MAX;
                    for (int i = 0; i < n; ++i) {
                        min_cost = min(min_cost, cost[i][j]);
                    }
                    total += min_cost;
                }
            }
            for (int j = 0; j < m; ++j) {
                if ((mask & (1 << j)) != 0) {
                    total += dp[mask][j];
                }
            }
            result = min(result, total);
        }

        return result;
    }
};