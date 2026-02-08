class Solution {
public:
    int countGoodStrings(int low, int high, int zero, int one) {
        const int MOD = 1e9 + 7;
        vector<long> dp(high + 1, 0);
        dp[0] = 1;
        for (int i = 0; i <= high; ++i) {
            if (i + zero <= high) {
                dp[i + zero] = (dp[i + zero] + dp[i]) % MOD;
            }
            if (i + one <= high) {
                dp[i + one] = (dp[i + one] + dp[i]) % MOD;
            }
        }
        long result = 0;
        for (int i = low; i <= high; ++i) {
            result = (result + dp[i]) % MOD;
        }
        return result;
    }
};