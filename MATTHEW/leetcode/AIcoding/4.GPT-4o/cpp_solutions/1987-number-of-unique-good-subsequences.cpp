#include <string>
#include <vector>

class Solution {
public:
    int countGoodSubsequences(std::string s) {
        const int MOD = 1e9 + 7;
        std::vector<long long> dp(s.size() + 1, 0);
        long long last = -1, count = 0;

        for (int i = 1; i <= s.size(); ++i) {
            dp[i] = (dp[i - 1] * 2) % MOD;
            if (s[i - 1] == '0') {
                dp[i] = (dp[i] + 1) % MOD;
            }
            if (s[i - 1] == '1') {
                if (last != -1) {
                    dp[i] = (dp[i] - dp[last] + MOD) % MOD;
                }
                last = i - 1;
            }
        }
        return (dp[s.size()] + MOD - 1) % MOD;
    }
};