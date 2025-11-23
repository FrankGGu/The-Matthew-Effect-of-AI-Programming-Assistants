class Solution {
public:
    int cherryPickup(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<vector<int>>> dp(m, vector<vector<int>>(n, vector<int>(n, -1)));
        return dfs(grid, dp, 0, 0, n - 1, m, n);
    }

    int dfs(vector<vector<int>>& grid, vector<vector<vector<int>>>& dp, int row, int col1, int col2, int m, int n) {
        if (row == m) return 0;
        if (dp[row][col1][col2] != -1) return dp[row][col1][col2];

        int res = 0;
        for (int i = -1; i <= 1; ++i) {
            for (int j = -1; j <= 1; ++j) {
                int newCol1 = col1 + i;
                int newCol2 = col2 + j;
                if (newCol1 >= 0 && newCol1 < n && newCol2 >= 0 && newCol2 < n) {
                    res = max(res, dfs(grid, dp, row + 1, newCol1, newCol2, m, n));
                }
            }
        }

        res += (col1 == col2) ? grid[row][col1] : grid[row][col1] + grid[row][col2];
        dp[row][col1][col2] = res;
        return res;
    }
};