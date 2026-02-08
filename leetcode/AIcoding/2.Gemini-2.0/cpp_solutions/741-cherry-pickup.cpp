#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int cherryPickup(vector<vector<int>>& grid) {
        int n = grid.size();
        vector<vector<int>> dp(n, vector<int>(n, -1e9));
        dp[0][0] = grid[0][0];

        for (int steps = 1; steps <= 2 * n - 2; ++steps) {
            vector<vector<int>> new_dp(n, vector<int>(n, -1e9));
            for (int r1 = max(0, steps - (n - 1)); r1 <= min(n - 1, steps); ++r1) {
                int c1 = steps - r1;
                if (grid[r1][c1] == -1) continue;
                for (int r2 = max(0, steps - (n - 1)); r2 <= min(n - 1, steps); ++r2) {
                    int c2 = steps - r2;
                    if (grid[r2][c2] == -1) continue;

                    int cherries = grid[r1][c1];
                    if (r1 != r2) cherries += grid[r2][c2];

                    new_dp[r1][r2] = max(new_dp[r1][r2], dp[r1][r2] + cherries);
                    if (r1 > 0) new_dp[r1][r2] = max(new_dp[r1][r2], dp[r1 - 1][r2] + cherries);
                    if (r2 > 0) new_dp[r1][r2] = max(new_dp[r1][r2], dp[r1][r2 - 1] + cherries);
                    if (r1 > 0 && r2 > 0) new_dp[r1][r2] = max(new_dp[r1][r2], dp[r1 - 1][r2 - 1] + cherries);
                }
            }
            dp = new_dp;
        }

        return max(0, dp[n - 1][n - 1]);
    }
};