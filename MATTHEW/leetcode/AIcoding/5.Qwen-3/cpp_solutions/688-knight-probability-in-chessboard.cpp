#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    double knightProbability(int n, int k, int row, int col) {
        vector<vector<double>> dp(n, vector<double>(n, 0.0));
        dp[row][col] = 1.0;
        vector<pair<int, int>> directions = {{-1, -2}, {-2, -1}, {-2, 1}, {-1, 2},
                                              {1, 2}, {2, 1}, {2, -1}, {1, -2}};

        for (int step = 0; step < k; ++step) {
            vector<vector<double>> next_dp(n, vector<double>(n, 0.0));
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (dp[i][j] == 0.0) continue;
                    for (const auto& dir : directions) {
                        int ni = i + dir.first;
                        int nj = j + dir.second;
                        if (ni >= 0 && ni < n && nj >= 0 && nj < n) {
                            next_dp[ni][nj] += dp[i][j] / 8.0;
                        }
                    }
                }
            }
            dp = next_dp;
        }

        double total = 0.0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                total += dp[i][j];
            }
        }
        return total;
    }
};