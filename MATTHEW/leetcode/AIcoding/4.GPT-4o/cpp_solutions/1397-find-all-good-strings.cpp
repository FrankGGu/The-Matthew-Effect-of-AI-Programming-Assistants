class Solution {
public:
    int countGoodStrings(int n, int minLimit, int maxLimit) {
        const int MOD = 1e9 + 7;
        vector<long> dp(n + 1);
        dp[0] = 1;
        long result = 0;

        for (int i = 1; i <= n; ++i) {
            for (char c = 'a'; c <= 'z'; ++c) {
                if (i - 1 >= 0) {
                    dp[i] = (dp[i] + dp[i - 1]) % MOD;
                }
            }
            if (i >= minLimit && i <= maxLimit) {
                result = (result + dp[i]) % MOD;
            }
        }
        return result;
    }
};