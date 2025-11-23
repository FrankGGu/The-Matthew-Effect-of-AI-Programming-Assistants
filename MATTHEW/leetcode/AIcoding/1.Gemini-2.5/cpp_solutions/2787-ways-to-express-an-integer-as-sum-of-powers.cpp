#include <vector>

class Solution {
public:
    int waysToReachTarget(int n, int x) {
        long long MOD = 1e9 + 7;
        std::vector<int> dp(n + 1, 0);
        dp[0] = 1;

        for (long long b = 1; ; ++b) {
            long long current_power = 1;
            bool too_large = false;

            for (int i = 0; i < x; ++i) {
                if (current_power > n / b) { 
                    too_large = true;
                    break;
                }
                current_power *= b;
            }

            if (too_large) {
                break;
            }

            for (int j = n; j >= current_power; --j) {
                dp[j] = (dp[j] + dp[j - current_power]) % MOD;
            }
        }

        return dp[n];
    }
};