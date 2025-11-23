#include <string>
#include <vector>

class Solution {
public:
    int countSpecialSubsequences(std::string s) {
        long long dp0 = 0; // Number of subsequences consisting only of '0's
        long long dp1 = 0; // Number of subsequences consisting of '0's followed by '1's
        long long dp2 = 0; // Number of subsequences consisting of '0's, '1's, and '2's

        long long MOD = 1e9 + 7;

        for (char c : s) {
            if (c == '0') {
                dp0 = (2 * dp0 + 1) % MOD;
            } else if (c == '1') {
                dp1 = (2 * dp1 + dp0) % MOD;
            } else if (c == '2') {
                dp2 = (2 * dp2 + dp1) % MOD;
            }
        }

        return static_cast<int>(dp2);
    }
};