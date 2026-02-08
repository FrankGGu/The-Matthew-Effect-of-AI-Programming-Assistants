#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int corneredPath(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<vector<int>>> dp(m, vector<vector<int>>(n, vector<int>(4, 0)));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int val = grid[i][j];
                if (val % 10 == 0) {
                    dp[i][j][0] = 1;
                    dp[i][j][1] = 1;
                    dp[i][j][2] = 1;
                    dp[i][j][3] = 1;
                }

                if (i > 0) {
                    dp[i][j][0] += dp[i-1][j][0];
                }
                if (j > 0) {
                    dp[i][j][1] += dp[i][j-1][1];
                }
                if (i > 0 && j > 0) {
                    dp[i][j][2] += dp[i-1][j-1][2];
                }
                if (i > 0 && j < n - 1) {
                    dp[i][j][3] += dp[i-1][j+1][3];
                }
            }
        }

        int maxZeros = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int count = 0;
                if (i > 0) count += dp[i][j][0];
                if (j > 0) count += dp[i][j][1];
                if (i > 0 && j > 0) count += dp[i][j][2];
                if (i > 0 && j < n - 1) count += dp[i][j][3];
                maxZeros = max(maxZeros, count);
            }
        }

        return maxZeros;
    }
};