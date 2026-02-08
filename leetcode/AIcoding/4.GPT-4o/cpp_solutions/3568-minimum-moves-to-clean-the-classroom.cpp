class Solution {
public:
    int minimumMoves(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = grid[0].size();
        vector<vector<int>> dp(n, vector<int>(m, INT_MAX));
        dp[0][0] = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (dp[i][j] == INT_MAX) continue;
                for (int x = 0; x < n; ++x) {
                    for (int y = 0; y < m; ++y) {
                        if (x == i && y == j) continue;
                        if (grid[x][y] == 1) continue;
                        int moves = abs(i - x) + abs(j - y);
                        dp[x][y] = min(dp[x][y], dp[i][j] + moves + 1);
                    }
                }
            }
        }
        return dp[n-1][m-1] == INT_MAX ? -1 : dp[n-1][m-1];
    }
};