#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minFallingPathSum(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<int>> dp(n, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            dp[0][i] = grid[0][i];
        }

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                dp[i][j] = INT_MAX;
                for (int k = 0; k < n; ++k) {
                    if (k != j) {
                        dp[i][j] = min(dp[i][j], dp[i - 1][k] + grid[i][j]);
                    }
                }
            }
        }

        int min_sum = INT_MAX;
        for (int i = 0; i < n; ++i) {
            min_sum = min(min_sum, dp[n - 1][i]);
        }

        return min_sum;
    }
};