#include <string>
#include <vector>
#include <cstring> // For memset

class Solution {
public:
    std::string S;
    int dp[10][1 << 10][2][2];

    int solve(int idx, int mask, bool is_tight, bool is_leading_zero) {
        if (idx == S.length()) {
            return is_leading_zero ? 0 : 1;
        }
        if (dp[idx][mask][is_tight][is_leading_zero] != -1) {
            return dp[idx][mask][is_tight][is_leading_zero];
        }

        int ans = 0;
        int upper_bound = is_tight ? (S[idx] - '0') : 9;

        for (int digit = 0; digit <= upper_bound; ++digit) {
            if (is_leading_zero) {
                if (digit == 0) {
                    ans += solve(idx + 1, mask, is_tight && (digit == upper_bound), true);
                } else {
                    ans += solve(idx + 1, mask | (1 << digit), is_tight && (digit == upper_bound), false);
                }
            } else {
                if (!((mask >> digit) & 1)) {
                    ans += solve(idx + 1, mask | (1 << digit), is_tight && (digit == upper_bound), false);
                }
            }
        }

        return dp[idx][mask][is_tight][is_leading_zero] = ans;
    }

    int countSpecialIntegers(int n) {
        S = std::to_string(n);
        memset(dp, -1, sizeof(dp));

        return solve(0, 0, true, true);
    }
};