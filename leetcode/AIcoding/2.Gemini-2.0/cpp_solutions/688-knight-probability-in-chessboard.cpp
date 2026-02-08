#include <vector>

using namespace std;

class Solution {
public:
    double knightProbability(int n, int k, int row, int column) {
        vector<vector<double>> dp(n, vector<double>(n, 0.0));
        dp[row][column] = 1.0;

        int dx[] = {-2, -1, 1, 2, -2, -1, 1, 2};
        int dy[] = {-1, -2, -2, -1, 1, 2, 2, 1};

        for (int step = 0; step < k; ++step) {
            vector<vector<double>> next_dp(n, vector<double>(n, 0.0));
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (dp[i][j] > 0) {
                        for (int dir = 0; dir < 8; ++dir) {
                            int next_x = i + dx[dir];
                            int next_y = j + dy[dir];
                            if (next_x >= 0 && next_x < n && next_y >= 0 && next_y < n) {
                                next_dp[next_x][next_y] += dp[i][j] / 8.0;
                            }
                        }
                    }
                }
            }
            dp = next_dp;
        }

        double total_probability = 0.0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                total_probability += dp[i][j];
            }
        }

        return total_probability;
    }
};