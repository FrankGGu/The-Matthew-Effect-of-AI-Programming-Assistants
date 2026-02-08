#include <vector>
#include <numeric> // For std::gcd

class Solution {
public:
    int distinctSequences(int n) {
        long long MOD = 1e9 + 7;

        std::vector<std::vector<long long>> dp(7, std::vector<long long>(7, 0));

        for (int i = 1; i <= 6; ++i) {
            dp[i][0] = 1;
        }

        for (int k = 1; k < n; ++k) {
            std::vector<std::vector<long long>> next_dp(7, std::vector<long long>(7, 0));

            for (int last_val = 1; last_val <= 6; ++last_val) {
                for (int second_last_val = 0; second_last_val <= 6; ++second_last_val) {
                    if (dp[last_val][second_last_val] == 0) {
                        continue;
                    }

                    for (int new_val = 1; new_val <= 6; ++new_val) {
                        if (new_val == last_val) {
                            continue;
                        }
                        if (second_last_val != 0 && new_val == second_last_val) {
                            continue;
                        }
                        if (std::gcd(new_val, last_val) != 1) {
                            continue;
                        }

                        next_dp[new_val][last_val] = (next_dp[new_val][last_val] + dp[last_val][second_last_val]) % MOD;
                    }
                }
            }
            dp = next_dp;
        }

        long long total_sequences = 0;
        for (int last_val = 1; last_val <= 6; ++last_val) {
            for (int second_last_val = 0; second_last_val <= 6; ++second_last_val) {
                total_sequences = (total_sequences + dp[last_val][second_last_val]) % MOD;
            }
        }

        return static_cast<int>(total_sequences);
    }
};