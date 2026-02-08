#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int gridGame(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = grid[0].size();
        vector<vector<int>> dp(n, vector<int>(m, 0));

        for (int i = 0; i < n; ++i) {
            dp[i][0] = grid[i][0];
        }

        for (int j = 0; j < m; ++j) {
            dp[0][j] = grid[0][j];
        }

        for (int i = 1; i < n; ++i) {
            for (int j = 1; j < m; ++j) {
                dp[i][j] = grid[i][j] + min(dp[i-1][j], dp[i][j-1]);
            }
        }

        return dp[n-1][m-1];
    }
};