#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int cherryPickup(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> dp(n, vector<int>(n, -1));

        for (int i = 0; i < n; ++i) {
            dp[0][i] = grid[0][i];
        }

        for (int row = 1; row < m; ++row) {
            vector<vector<int>> new_dp(n, vector<int>(n, -1));
            for (int col1 = 0; col1 < n; ++col1) {
                for (int col2 = 0; col2 < n; ++col2) {
                    if (dp[col1][col2] == -1) continue;
                    for (int d1 = -1; d1 <= 1; ++d1) {
                        for (int d2 = -1; d2 <= 1; ++d2) {
                            int new_col1 = col1 + d1;
                            int new_col2 = col2 + d2;
                            if (new_col1 >= 0 && new_col1 < n && new_col2 >= 0 && new_col2 < n) {
                                int val = grid[row][new_col1] + (new_col1 != new_col2 ? grid[row][new_col2] : 0);
                                new_dp[new_col1][new_col2] = max(new_dp[new_col1][new_col2], dp[col1][col2] + val);
                            }
                        }
                    }
                }
            }
            dp = new_dp;
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                result = max(result, dp[i][j]);
            }
        }
        return result;
    }
};