#include <iostream>
#include <vector>
#include <unordered_map>
#include <cmath>

using namespace std;

class Solution {
public:
    int pathSum(vector<vector<int>>& grid, int k) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<vector<int>>> dp(m, vector<vector<int>>(n, vector<int>(k, 0)));
        vector<vector<unordered_map<int, int>>> prefix_sum(m, vector<unordered_map<int, int>>(n));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == 0 && j == 0) {
                    int mod = grid[i][j] % k;
                    if (mod < 0) mod += k;
                    dp[i][j][mod] = 1;
                    prefix_sum[i][j][mod] = 1;
                } else {
                    if (i > 0) {
                        for (int p = 0; p < k; ++p) {
                            int prev_mod = (p - grid[i][j]) % k;
                            if (prev_mod < 0) prev_mod += k;
                            dp[i][j][p] += dp[i-1][j][prev_mod];
                        }
                    }
                    if (j > 0) {
                        for (int p = 0; p < k; ++p) {
                            int prev_mod = (p - grid[i][j]) % k;
                            if (prev_mod < 0) prev_mod += k;
                            dp[i][j][p] += dp[i][j-1][prev_mod];
                        }
                    }
                    for (int p = 0; p < k; ++p) {
                        int mod = (grid[i][j] + p) % k;
                        if (mod < 0) mod += k;
                        prefix_sum[i][j][mod] = dp[i][j][p];
                    }
                }
            }
        }
        return dp[m-1][n-1][0];
    }
};