#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxProductPath(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<long long>> max_dp(m, vector<long long>(n));
        vector<vector<long long>> min_dp(m, vector<long long>(n));

        max_dp[0][0] = grid[0][0];
        min_dp[0][0] = grid[0][0];

        for (int i = 1; i < m; ++i) {
            max_dp[i][0] = max_dp[i - 1][0] * grid[i][0];
            min_dp[i][0] = min_dp[i - 1][0] * grid[i][0];
        }

        for (int j = 1; j < n; ++j) {
            max_dp[0][j] = max_dp[0][j - 1] * grid[0][j];
            min_dp[0][j] = min_dp[0][j - 1] * grid[0][j];
        }

        for (int i = 1; i < m; ++i) {
            for (int j = 1; j < n; ++j) {
                long long opt1 = max_dp[i - 1][j] * grid[i][j];
                long long opt2 = min_dp[i - 1][j] * grid[i][j];
                long long opt3 = max_dp[i][j - 1] * grid[i][j];
                long long opt4 = min_dp[i][j - 1] * grid[i][j];

                max_dp[i][j] = max({opt1, opt2, opt3, opt4});
                min_dp[i][j] = min({opt1, opt2, opt3, opt4});
            }
        }

        long long result = max_dp[m - 1][n - 1];
        if (result < 0) {
            return -1;
        } else {
            return result % 1000000007;
        }
    }
};