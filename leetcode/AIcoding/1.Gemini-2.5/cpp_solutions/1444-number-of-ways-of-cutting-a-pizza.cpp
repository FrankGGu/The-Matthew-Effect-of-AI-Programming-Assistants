#include <vector>
#include <string>

class Solution {
public:
    int ways(std::vector<std::string>& pizza, int k) {
        int R = pizza.size();
        int C = pizza[0].size();
        long long MOD = 1e9 + 7;

        std::vector<std::vector<int>> apples(R + 1, std::vector<int>(C + 1, 0));
        for (int r = R - 1; r >= 0; --r) {
            for (int c = C - 1; c >= 0; --c) {
                apples[r][c] = (pizza[r][c] == 'A' ? 1 : 0)
                               + apples[r + 1][c]
                               + apples[r][c + 1]
                               - apples[r + 1][c + 1];
            }
        }

        std::vector<std::vector<std::vector<long long>>> dp(k, std::vector<std::vector<long long>>(R, std::vector<long long>(C, 0)));

        for (int r = 0; r < R; ++r) {
            for (int c = 0; c < C; ++c) {
                if (apples[r][c] > 0) {
                    dp[0][r][c] = 1;
                }
            }
        }

        for (int cuts_left = 1; cuts_left < k; ++cuts_left) {
            for (int r = 0; r < R; ++r) {
                for (int c = 0; c < C; ++c) {
                    if (apples[r][c] == 0) {
                        continue;
                    }

                    for (int next_r = r + 1; next_r < R; ++next_r) {
                        if (apples[r][c] - apples[next_r][c] > 0) {
                            dp[cuts_left][r][c] = (dp[cuts_left][r][c] + dp[cuts_left - 1][next_r][c]) % MOD;
                        }
                    }

                    for (int next_c = c + 1; next_c < C; ++next_c) {
                        if (apples[r][c] - apples[r][next_c] > 0) {
                            dp[cuts_left][r][c] = (dp[cuts_left][r][c] + dp[cuts_left - 1][r][next_c]) % MOD;
                        }
                    }
                }
            }
        }

        return dp[k - 1][0][0];
    }
};