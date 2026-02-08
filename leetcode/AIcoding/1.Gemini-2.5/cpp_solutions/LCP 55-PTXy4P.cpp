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
                apples[r][c] = (pizza[r][c] == 'A' ? 1 : 0) + 
                               apples[r+1][c] + 
                               apples[r][c+1] - 
                               apples[r+1][c+1];
            }
        }

        auto hasApple = [&](int r1, int c1, int r2, int c2) {
            return apples[r1][c1] - apples[r2+1][c1] - apples[r1][c2+1] + apples[r2+1][c2+1] > 0;
        };

        std::vector<std::vector<std::vector<long long>>> dp(k + 1, std::vector<std::vector<long long>>(R, std::vector<long long>(C, 0)));

        for (int r = 0; r < R; ++r) {
            for (int c = 0; c < C; ++c) {
                if (hasApple(r, c, R - 1, C - 1)) {
                    dp[1][r][c] = 1;
                }
            }
        }

        for (int k_prime = 2; k_prime <= k; ++k_prime) {
            for (int r = R - 1; r >= 0; --r) {
                for (int c = C - 1; c >= 0; --c) {
                    if (!hasApple(r, c, R - 1, C - 1)) {
                        continue;
                    }

                    for (int nr = r + 1; nr < R; ++nr) {
                        if (hasApple(r, c, nr - 1, C - 1)) {
                            dp[k_prime][r][c] = (dp[k_prime][r][c] + dp[k_prime - 1][nr][c]) % MOD;
                        }
                    }

                    for (int nc = c + 1; nc < C; ++nc) {
                        if (hasApple(r, c, R - 1, nc - 1)) {
                            dp[k_prime][r][c] = (dp[k_prime][r][c] + dp[k_prime - 1][r][nc]) % MOD;
                        }
                    }
                }
            }
        }

        return dp[k][0][0];
    }
};