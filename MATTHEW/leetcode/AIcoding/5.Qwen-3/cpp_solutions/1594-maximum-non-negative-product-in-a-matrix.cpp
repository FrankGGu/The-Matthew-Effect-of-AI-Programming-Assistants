#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxProductPath(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        const int MOD = 1e9 + 7;

        vector<vector<pair<long long, long long>>> dp(m, vector<pair<long long, long long>>(n));

        dp[0][0] = {grid[0][0], grid[0][0]};

        for (int i = 1; i < m; ++i) {
            dp[i][0].first = dp[i-1][0].first * grid[i][0];
            dp[i][0].second = dp[i-1][0].second * grid[i][0];
        }

        for (int j = 1; j < n; ++j) {
            dp[0][j].first = dp[0][j-1].first * grid[0][j];
            dp[0][j].second = dp[0][j-1].second * grid[0][j];
        }

        for (int i = 1; i < m; ++i) {
            for (int j = 1; j < n; ++j) {
                long long a = dp[i-1][j].first * grid[i][j];
                long long b = dp[i-1][j].second * grid[i][j];
                long long c = dp[i][j-1].first * grid[i][j];
                long long d = dp[i][j-1].second * grid[i][j];

                dp[i][j].first = max(a, max(b, max(c, d)));
                dp[i][j].second = min(a, min(b, min(c, d)));
            }
        }

        return max(dp[m-1][n-1].first, dp[m-1][n-1].second) % MOD;
    }
};