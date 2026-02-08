class Solution {
public:
    int findPaths(int m, int n, int maxMove, int startRow, int startColumn) {
        const int MOD = 1e9 + 7;
        vector<vector<vector<int>>> dp(maxMove + 1, vector<vector<int>>(m, vector<int>(n, 0)));
        vector<pair<int, int>> directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        for (int move = 1; move <= maxMove; ++move) {
            for (int i = 0; i < m; ++i) {
                for (int j = 0; j < n; ++j) {
                    for (auto& dir : directions) {
                        int ni = i + dir.first;
                        int nj = j + dir.second;
                        if (ni < 0 || ni >= m || nj < 0 || nj >= n) {
                            dp[move][i][j] = (dp[move][i][j] + 1) % MOD;
                        } else {
                            dp[move][i][j] = (dp[move][i][j] + dp[move - 1][ni][nj]) % MOD;
                        }
                    }
                }
            }
        }

        return dp[maxMove][startRow][startColumn];
    }
};