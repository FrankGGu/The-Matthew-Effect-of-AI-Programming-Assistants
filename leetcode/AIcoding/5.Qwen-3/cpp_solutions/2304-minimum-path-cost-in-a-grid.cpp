#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int minPathCost(vector<vector<int>>& grid, vector<vector<int>>& moveCost) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> dp(m, vector<int>(n, 0));

        for (int j = 0; j < n; ++j) {
            dp[0][j] = grid[0][j];
        }

        for (int i = 1; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int minPrev = INT_MAX;
                for (int k = 0; k < n; ++k) {
                    minPrev = min(minPrev, dp[i-1][k] + moveCost[grid[i-1][k]][j]);
                }
                dp[i][j] = minPrev + grid[i][j];
            }
        }

        int result = INT_MAX;
        for (int j = 0; j < n; ++j) {
            result = min(result, dp[m-1][j]);
        }

        return result;
    }
};