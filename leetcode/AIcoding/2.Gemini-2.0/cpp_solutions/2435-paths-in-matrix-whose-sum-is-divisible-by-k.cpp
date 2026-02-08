#include <vector>

using namespace std;

class Solution {
public:
    int numberOfPaths(vector<vector<int>>& grid, int k) {
        int m = grid.size();
        int n = grid[0].size();
        int mod = 1e9 + 7;

        vector<vector<vector<int>>> dp(m, vector<vector<int>>(n, vector<int>(k, 0)));

        dp[0][0][grid[0][0] % k] = 1;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                for (int rem = 0; rem < k; ++rem) {
                    if (i > 0) {
                        dp[i][j][(rem + grid[i][j]) % k] = (dp[i][j][(rem + grid[i][j]) % k] + dp[i - 1][j][rem]) % mod;
                    }
                    if (j > 0) {
                        dp[i][j][(rem + grid[i][j]) % k] = (dp[i][j][(rem + grid[i][j]) % k] + dp[i][j - 1][rem]) % mod;
                    }
                }
            }
        }

        return dp[m - 1][n - 1][0];
    }
};