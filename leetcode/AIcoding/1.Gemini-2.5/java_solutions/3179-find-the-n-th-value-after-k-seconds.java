class Solution {
    private static final int MOD = 1_000_000_007;

    public int valueAfterKSeconds(int n, int k) {
        // The problem asks for the value at the last index (n-1) after k seconds.
        // Let dp[s][i] be the value at index i after s seconds.
        // dp[0][i] = 1 for all i.
        // The recurrence relation is dp[s][i] = sum(dp[s-1][j] for j from 0 to i).
        // This can be simplified to dp[s][i] = dp[s][i-1] + dp[s-1][i] for i > 0,
        // with dp[s][0] = 1.
        // This recurrence is characteristic of binomial coefficients.
        // Specifically, dp[s][i] = C(s + i, s) or C(s + i, i).
        // We need to find dp[k][n-1], which is C(k + (n-1), k) or C(k + (n-1), n-1).

        // Let N_val = k + n - 1 (the 'n' in C(n, k))
        // Let K_eff = k (the 'k' in C(n, k))
        // We can also use K_eff = n - 1, whichever is smaller, to optimize calculations.
        long N_val = (long)k + n - 1;
        long K_eff = Math.min((long)k, (long)n - 1);

        long result = 1;

        // Calculate C(N_val, K_eff) modulo MOD
        // C(N, K) = (N * (N-1) * ... * (N-K+1)) / (K * (K-1) * ... * 1)
        // We compute this iteratively, performing division by multiplying with modular inverse.
        for (int i = 0; i < K_eff; i++) {
            result = (result * (N_val - i)) % MOD;
            result = (result * modInverse(i + 1, MOD)) % MOD;
        }

        return (int)result;
    }

    // Computes (base^exp) % MOD using binary exponentiation (exponentiation by squaring).
    private long power(long base, long exp) {
        long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }

    // Computes the modular multiplicative inverse of n modulo MOD.
    // Since MOD is a prime number, we can use Fermat's Little Theorem:
    // n^(MOD-2) % MOD is the modular inverse of n.
    private long modInverse(long n, long mod) {
        return power(n, mod - 2);
    }
}