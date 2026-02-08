#include <vector>
#include <climits>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minCost(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return 0;
        int n = grid[0].size();
        if (n == 0) return 0;

        vector<vector<int>> dp(m, vector<int>(n, INT_MAX));
        dp[0][0] = 0;

        int dirs[4][2] = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                for (int k = 0; k < 4; ++k) {
                    int x = i + dirs[k][0];
                    int y = j + dirs[k][1];
                    if (x >= 0 && x < m && y >= 0 && y < n) {
                        int cost = (grid[i][j] == k + 1) ? 0 : 1;
                        dp[x][y] = min(dp[x][y], dp[i][j] + cost);
                    }
                }
            }
        }

        return dp[m-1][n-1];
    }
};