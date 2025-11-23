class Solution {
    private static final int MOD = 1000000007;

    public int idealArrays(int n, int maxValue) {
        long[][] dp = new long[maxValue + 1][16];
        for (int i = 1; i <= maxValue; i++) {
            dp[i][1] = 1;
        }

        for (int len = 2; len <= Math.min(n, 15); len++) {
            for (int i = 1; i <= maxValue; i++) {
                for (int j = i + i; j <= maxValue; j += i) {
                    dp[j][len] = (dp[j][len] + dp[i][len - 1]) % MOD;
                }
            }
        }

        long ans = 0;
        for (int i = 1; i <= maxValue; i++) {
            for (int len = 1; len <= Math.min(n, 15); len++) {
                ans = (ans + dp[i][len] * combinations(n - 1, len - 1)) % MOD;
            }
        }

        return (int) ans;
    }

    private long combinations(int n, int k) {
        if (k < 0 || k > n) {
            return 0;
        }
        if (k == 0 || k == n) {
            return 1;
        }
        if (k > n / 2) {
            k = n - k;
        }

        long res = 1;
        for (int i = 1; i <= k; ++i) {
            res = res * (n - i + 1) / i;
        }
        return res % MOD;
    }

    private long factorial(int n) {
        long res = 1;
        for (int i = 2; i <= n; i++) {
            res = (res * i) % MOD;
        }
        return res;
    }

    private long power(long base, int exp) {
        long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp >>= 1;
        }
        return res;
    }

    private long modInverse(long n) {
        return power(n, MOD - 2);
    }
}