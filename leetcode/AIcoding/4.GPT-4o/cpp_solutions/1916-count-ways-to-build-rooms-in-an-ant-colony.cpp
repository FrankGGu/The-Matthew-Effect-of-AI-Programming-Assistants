class Solution {
public:
    int countWays(vector<int>& A) {
        int n = A.size();
        const int MOD = 1e9 + 7;
        vector<long> dp(n + 1, 0);
        dp[0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= i; ++j) {
                dp[i] = (dp[i] + dp[i - j] * comb(i - 1, j - 1, MOD)) % MOD;
            }
        }

        return dp[n];
    }

private:
    long comb(int n, int k, int MOD) {
        if (k > n) return 0;
        long res = 1;
        for (int i = 0; i < k; ++i) {
            res = res * (n - i) % MOD;
            res = res * modInverse(i + 1, MOD) % MOD;
        }
        return res;
    }

    long modInverse(long a, long MOD) {
        long m0 = MOD, y = 0, x = 1;
        if (MOD == 1) return 0;
        while (a > 1) {
            long q = a / MOD;
            long t = MOD;
            MOD = a % MOD, a = t;
            t = y;
            y = x - q * y;
            x = t;
        }
        if (x < 0) x += m0;
        return x;
    }
};