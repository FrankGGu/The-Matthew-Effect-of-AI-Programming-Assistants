#include <vector>
#include <numeric>

class Solution {
public:
    int specialPerm(std::vector<int>& nums) {
        int n = nums.size();
        long long MOD = 1e9 + 7;

        std::vector<std::vector<long long>> dp(1 << n, std::vector<long long>(n, 0));

        for (int i = 0; i < n; ++i) {
            dp[1 << i][i] = 1;
        }

        for (int mask = 1; mask < (1 << n); ++mask) {
            for (int j = 0; j < n; ++j) {
                if (!(mask & (1 << j))) {
                    continue;
                }

                if (mask == (1 << j)) {
                    continue;
                }

                int prev_mask = mask ^ (1 << j);
                for (int k = 0; k < n; ++k) {
                    if (prev_mask & (1 << k)) {
                        if (nums[j] % nums[k] == 0 || nums[k] % nums[j] == 0) {
                            dp[mask][j] = (dp[mask][j] + dp[prev_mask][k]) % MOD;
                        }
                    }
                }
            }
        }

        long long totalSpecialPermutations = 0;
        int fullMask = (1 << n) - 1;
        for (int i = 0; i < n; ++i) {
            totalSpecialPermutations = (totalSpecialPermutations + dp[fullMask][i]) % MOD;
        }

        return static_cast<int>(totalSpecialPermutations);
    }
};