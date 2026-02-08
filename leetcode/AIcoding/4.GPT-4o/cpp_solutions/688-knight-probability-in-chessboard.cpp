class Solution {
public:
    double knightProbability(int n, int k, int row, int column) {
        vector<vector<vector<double>>> dp(k + 1, vector<vector<double>>(n, vector<double>(n, 0.0)));
        dp[0][row][column] = 1.0;

        vector<int> directions = {-2, -1, 1, 2};

        for (int step = 1; step <= k; ++step) {
            for (int r = 0; r < n; ++r) {
                for (int c = 0; c < n; ++c) {
                    for (int dr : directions) {
                        for (int dc : directions) {
                            if (abs(dr) != abs(dc)) {
                                int newRow = r + dr;
                                int newCol = c + dc;
                                if (newRow >= 0 && newRow < n && newCol >= 0 && newCol < n) {
                                    dp[step][newRow][newCol] += dp[step - 1][r][c] / 8.0;
                                }
                            }
                        }
                    }
                }
            }
        }

        double result = 0.0;
        for (int r = 0; r < n; ++r) {
            for (int c = 0; c < n; ++c) {
                result += dp[k][r][c];
            }
        }
        return result;
    }
};