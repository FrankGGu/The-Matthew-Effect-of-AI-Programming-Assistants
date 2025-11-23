class Solution {
public:
    vector<int> findSafePath(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<int>> dp(m, vector<int>(n, INT_MAX));
        dp[0][0] = grid[0][0];

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i > 0) dp[i][j] = min(dp[i][j], max(dp[i-1][j], grid[i][j]));
                if (j > 0) dp[i][j] = min(dp[i][j], max(dp[i][j-1], grid[i][j]));
            }
        }

        vector<int> result;
        int x = m - 1, y = n - 1;
        while (x > 0 || y > 0) {
            result.push_back(grid[x][y]);
            if (x > 0 && (y == 0 || dp[x-1][y] < dp[x][y-1])) {
                x--;
            } else {
                y--;
            }
        }
        result.push_back(grid[0][0]);
        reverse(result.begin(), result.end());

        return result;
    }
};