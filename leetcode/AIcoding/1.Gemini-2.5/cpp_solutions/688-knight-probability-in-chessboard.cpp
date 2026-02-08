#include <vector>

class Solution {
public:
    double knightProbability(int n, int k, int r, int c) {
        if (k == 0) {
            return 1.0;
        }

        std::vector<std::vector<double>> prev_dp(n, std::vector<double>(n, 0.0));
        std::vector<std::vector<double>> curr_dp(n, std::vector<double>(n, 0.0));

        prev_dp[r][c] = 1.0;

        int dr[] = {-2, -2, -1, -1, 1, 1, 2, 2};
        int dc[] = {-1, 1, -2, 2, -2, 2, -1, 1};

        for (int moves = 1; moves <= k; ++moves) {
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    curr_dp[i][j] = 0.0;
                }
            }

            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (prev_dp[i][j] > 0) {
                        for (int move_idx = 0; move_idx < 8; ++move_idx) {
                            int next_r = i + dr[move_idx];
                            int next_c = j + dc[move_idx];

                            if (next_r >= 0 && next_r < n && next_c >= 0 && next_c < n) {
                                curr_dp[next_r][next_c] += prev_dp[i][j] * (1.0 / 8.0);
                            }
                        }
                    }
                }
            }
            prev_dp = curr_dp;
        }

        double total_probability = 0.0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                total_probability += prev_dp[i][j];
            }
        }

        return total_probability;
    }
};