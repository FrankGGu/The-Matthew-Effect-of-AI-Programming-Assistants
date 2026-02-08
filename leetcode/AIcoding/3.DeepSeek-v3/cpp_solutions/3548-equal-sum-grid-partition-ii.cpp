class Solution {
public:
    bool canPartition(vector<vector<int>>& grid) {
        int m = grid.size();
        if (m == 0) return false;
        int n = grid[0].size();
        if (n == 0) return false;

        int total = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                total += grid[i][j];
            }
        }
        if (total % 2 != 0) return false;
        int target = total / 2;

        vector<vector<bool>> dp(m + 1, vector<bool>(target + 1, false));
        dp[0][0] = true;

        for (int i = 1; i <= m; ++i) {
            int sum_row = 0;
            for (int num : grid[i - 1]) {
                sum_row += num;
            }
            for (int j = 0; j <= target; ++j) {
                if (dp[i - 1][j]) {
                    dp[i][j] = true;
                    if (j + sum_row <= target) {
                        dp[i][j + sum_row] = true;
                    }
                }
            }
            if (dp[i][target]) return true;
        }
        return false;
    }
};