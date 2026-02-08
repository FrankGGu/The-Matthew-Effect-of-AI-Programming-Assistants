#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countPyramids(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = grid[0].size();
        vector<vector<int>> dp(n, vector<int>(m, 0));

        for (int i = n - 1; i >= 0; --i) {
            for (int j = 0; j < m; ++j) {
                if (grid[i][j] == 1) {
                    if (i == n - 1 || j == 0 || j == m - 1) {
                        dp[i][j] = 1;
                    } else {
                        dp[i][j] = min(dp[i + 1][j - 1], min(dp[i + 1][j], dp[i + 1][j + 1])) + 1;
                    }
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (dp[i][j] >= 2) {
                    result += dp[i][j] - 1;
                }
            }
        }

        return result;
    }
};