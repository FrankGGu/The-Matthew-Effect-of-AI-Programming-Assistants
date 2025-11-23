import java.util.Arrays;

class Solution {
    private static final int MOD = 1_000_000_007;
    private long[] fact;
    private long[] invFact;

    private void precomputeFactorials(int n) {
        fact = new long[n + 1];
        invFact = new long[n + 1];
        fact[0] = 1;
        invFact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }
        invFact[n] = power(fact[n], MOD - 2);
        for (int i = n - 1; i >= 1; i--) {
            invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
        }
    }

    private long power(long base, long exp) {
        long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    public int numberOfSequence(int n, int[] sick) {
        Arrays.sort(sick);
        precomputeFactorials(n);

        long ans = 1;
        long totalHealthy = n - sick.length;
        long waysInInternalGaps = 1;

        // Leftmost gap
        if (sick[0] > 0) {
            long L = sick[0];
            ans = (ans * invFact[(int) L]) % MOD;
        }

        // Rightmost gap
        if (sick[sick.length - 1] < n - 1) {
            long R = n - 1 - sick[sick.length - 1];
            ans = (ans * invFact[(int) R]) % MOD;
        }

        // Internal gaps
        for (int i = 0; i < sick.length - 1; i++) {
            long G = sick[i + 1] - sick[i] - 1;
            if (G > 0) {
                ans = (ans * invFact[(int) G]) % MOD;
                waysInInternalGaps = (waysInInternalGaps * power(2, G - 1)) % MOD;
            }
        }

        ans = (ans * fact[(int) totalHealthy]) % MOD;
        ans = (ans * waysInInternalGaps) % MOD;

        return (int) ans;
    }
}