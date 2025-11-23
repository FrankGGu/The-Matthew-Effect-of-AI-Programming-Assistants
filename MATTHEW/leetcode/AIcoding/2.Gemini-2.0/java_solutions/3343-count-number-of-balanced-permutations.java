class Solution {
    private static final int MOD = 1_000_000_007;

    public int countBalancedPermutations(int n) {
        long[] fact = new long[n + 1];
        fact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }

        long ans = fact[n / 2];
        ans = (ans * ans) % MOD;

        long inv = power(2, n / 2, MOD);
        ans = (ans * inv) % MOD;

        return (int) ans;
    }

    private long power(long base, long exp, long mod) {
        long res = 1;
        base %= mod;
        while (exp > 0) {
            if ((exp & 1) == 1) res = (res * base) % mod;
            base = (base * base) % mod;
            exp >>= 1;
        }
        return res;
    }
}