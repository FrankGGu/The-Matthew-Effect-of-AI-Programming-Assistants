class Solution {
public:
    int maxMoves(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> dp(m, vector<int>(n, 0));
        int maxMoves = 0;

        for (int j = n - 2; j >= 0; --j) {
            for (int i = 0; i < m; ++i) {
                int current = grid[i][j];
                int moves = 0;

                if (i > 0 && grid[i - 1][j + 1] > current) {
                    moves = max(moves, dp[i - 1][j + 1] + 1);
                }
                if (grid[i][j + 1] > current) {
                    moves = max(moves, dp[i][j + 1] + 1);
                }
                if (i < m - 1 && grid[i + 1][j + 1] > current) {
                    moves = max(moves, dp[i + 1][j + 1] + 1);
                }

                dp[i][j] = moves;
                if (j == 0) {
                    maxMoves = max(maxMoves, moves);
                }
            }
        }

        return maxMoves;
    }
};