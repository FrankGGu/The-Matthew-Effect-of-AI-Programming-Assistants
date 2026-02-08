#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int connectTwoGroups(vector<vector<int>>& cost) {
        int n = cost.size();
        int m = cost[0].size();

        vector<int> minCost(m, INT_MAX);
        for (int j = 0; j < m; ++j) {
            for (int i = 0; i < n; ++i) {
                minCost[j] = min(minCost[j], cost[i][j]);
            }
        }

        vector<vector<int>> dp(n + 1, vector<int>(1 << m, 1e9));
        dp[0][0] = 0;

        for (int i = 0; i < n; ++i) {
            for (int mask = 0; mask < (1 << m); ++mask) {
                if (dp[i][mask] == 1e9) continue;
                for (int j = 0; j < m; ++j) {
                    dp[i + 1][mask | (1 << j)] = min(dp[i + 1][mask | (1 << j)], dp[i][mask] + cost[i][j]);
                }
                dp[i + 1][mask] = min(dp[i + 1][mask], dp[i][mask] + *min_element(minCost.begin(), minCost.end()));
            }
        }

        int ans = dp[n][(1 << m) - 1];
        return ans;
    }
};