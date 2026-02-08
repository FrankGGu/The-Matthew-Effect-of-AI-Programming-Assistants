class Solution {
public:
    double knightProbability(int N, int K, int r, int c) {
        vector<vector<vector<double>>> dp(K + 1, vector<vector<double>>(N, vector<double>(N, 0.0)));
        vector<vector<int>> dirs = {{-2, -1}, {-1, -2}, {1, -2}, {2, -1}, {2, 1}, {1, 2}, {-1, 2}, {-2, 1}};
        dp[0][r][c] = 1.0;
        for (int step = 1; step <= K; ++step) {
            for (int i = 0; i < N; ++i) {
                for (int j = 0; j < N; ++j) {
                    for (const auto& dir : dirs) {
                        int x = i + dir[0];
                        int y = j + dir[1];
                        if (x >= 0 && x < N && y >= 0 && y < N) {
                            dp[step][i][j] += dp[step - 1][x][y] / 8.0;
                        }
                    }
                }
            }
        }
        double res = 0.0;
        for (int i = 0; i < N; ++i) {
            for (int j = 0; j < N; ++j) {
                res += dp[K][i][j];
            }
        }
        return res;
    }
};