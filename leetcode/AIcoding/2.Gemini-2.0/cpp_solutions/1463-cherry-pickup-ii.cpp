#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int cherryPickup(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        vector<vector<int>> dp(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == j) {
                    dp[i][j] = grid[0][i];
                } else {
                    dp[i][j] = grid[0][i] + grid[0][j];
                }
            }
        }

        for (int row = 1; row < m; ++row) {
            vector<vector<int>> new_dp(n, vector<int>(n, -1));
            for (int col1 = 0; col1 < n; ++col1) {
                for (int col2 = 0; col2 < n; ++col2) {
                    for (int prev_col1 = max(0, col1 - 1); prev_col1 <= min(n - 1, col1 + 1); ++prev_col1) {
                        for (int prev_col2 = max(0, col2 - 1); prev_col2 <= min(n - 1, col2 + 1); ++prev_col2) {
                            if (dp[prev_col1][prev_col2] != -1) {
                                int cherries = dp[prev_col1][prev_col2];
                                if (col1 == col2) {
                                    cherries += grid[row][col1];
                                } else {
                                    cherries += grid[row][col1] + grid[row][col2];
                                }
                                new_dp[col1][col2] = max(new_dp[col1][col2], cherries);
                            }
                        }
                    }
                }
            }
            dp = new_dp;
        }

        int max_cherries = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                max_cherries = max(max_cherries, dp[i][j]);
            }
        }

        return max_cherries;
    }
};