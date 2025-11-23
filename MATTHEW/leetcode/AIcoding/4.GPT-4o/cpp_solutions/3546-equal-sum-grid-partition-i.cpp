class Solution {
public:
    bool canPartition(vector<vector<int>>& grid) {
        int n = grid.size(), m = grid[0].size();
        int total_sum = 0;
        for (const auto& row : grid) {
            for (int num : row) {
                total_sum += num;
            }
        }
        if (total_sum % 2 != 0) return false;
        int target = total_sum / 2;

        vector<vector<bool>> dp(n + 1, vector<bool>(target + 1, false));
        dp[0][0] = true;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j <= target; ++j) {
                dp[i][j] = dp[i - 1][j];
                for (int k = 0; k < m; ++k) {
                    if (j >= grid[i - 1][k]) {
                        dp[i][j] = dp[i][j] || dp[i - 1][j - grid[i - 1][k]];
                    }
                }
            }
        }
        return dp[n][target];
    }
};