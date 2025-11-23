#include <vector>

class Solution {
public:
    int numTilings(int n) {
        if (n == 1) {
            return 1;
        }
        if (n == 2) {
            return 5;
        }

        long long MOD = 1e9 + 7;
        std::vector<long long> dp(n + 1);

        // Base cases for the recurrence
        // dp[i] = 2 * dp[i-1] + dp[i-3]
        // This recurrence requires dp[0], dp[1], dp[2] to be set.
        // dp[0] is typically 1 for an empty board in such problems,
        // which helps the recurrence work for dp[3].
        dp[0] = 1; 
        dp[1] = 1;
        dp[2] = 5;

        for (int i = 3; i <= n; ++i) {
            dp[i] = (2 * dp[i-1] % MOD + dp[i-3] % MOD) % MOD;
        }

        return dp[n];
    }
};