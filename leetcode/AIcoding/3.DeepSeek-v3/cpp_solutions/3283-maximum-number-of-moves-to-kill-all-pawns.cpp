class Solution {
public:
    int maxMoves(vector<vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> dp(m, vector<int>(n, 0));
        int maxMoves = 0;

        for (int j = n - 2; j >= 0; --j) {
            for (int i = 0; i < m; ++i) {
                int maxNext = 0;
                for (int di = -1; di <= 1; ++di) {
                    int ni = i + di;
                    if (ni >= 0 && ni < m && j + 1 < n && grid[ni][j + 1] > grid[i][j]) {
                        maxNext = max(maxNext, dp[ni][j + 1] + 1);
                    }
                }
                dp[i][j] = maxNext;
                if (j == 0) {
                    maxMoves = max(maxMoves, dp[i][j]);
                }
            }
        }

        return maxMoves;
    }
};