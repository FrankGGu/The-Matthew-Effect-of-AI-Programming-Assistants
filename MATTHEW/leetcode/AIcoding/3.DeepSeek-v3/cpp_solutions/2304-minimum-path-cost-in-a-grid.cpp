class Solution {
public:
    int minPathCost(vector<vector<int>>& grid, vector<vector<int>>& moveCost) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> dp(m, vector<int>(n, INT_MAX));

        for (int j = 0; j < n; ++j) {
            dp[0][j] = grid[0][j];
        }

        for (int i = 1; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                for (int k = 0; k < n; ++k) {
                    int prevVal = grid[i-1][k];
                    dp[i][j] = min(dp[i][j], dp[i-1][k] + moveCost[prevVal][j] + grid[i][j]);
                }
            }
        }

        return *min_element(dp[m-1].begin(), dp[m-1].end());
    }
};