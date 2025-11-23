class Solution {
    private static final int MOD = 1_000_000_007;
    // Max n + max_exponent_for_2_in_10^9.
    // Max n = 10^5. Max exponent for 2 in 10^9 is 29 (2^29 = 536,870,912, 2^30 = 1,073,741,824).
    // So, max value for (count + n - 1) is (29 + 100000 - 1) = 100028.
    // We need arrays up to this index.
    private static final int MAX_COMB_N = 100000 + 30; 

    private long[] fact;
    private long[] invFact;

    public int waysToMakeProduct(int n, int product) {
        fact = new long[MAX_COMB_N];
        invFact = new long[MAX_COMB_N];
        precomputeFactorials();

        long ans = 1;

        // Prime factorization of 'product'
        // Iterate up to sqrt(product) to find prime factors
        for (int i = 2; (long)i * i <= product; i++) {
            if (product % i == 0) {
                int count = 0; // exponent of prime i
                while (product % i == 0) {
                    product /= i;
                    count++;
                }
                // For each prime factor p with exponent 'count', we need to distribute 'count' occurrences
                // among 'n' positive integers. This is a stars and bars problem.
                // The number of ways is C(count + n - 1, n - 1).
                // Here, n-1 is the number of 'bars' (separators).
                // count is the number of 'stars' (items to distribute).
                ans = (ans * nCr_mod_p(count + n - 1, n - 1)) % MOD;
            }
        }

        // If product is still greater than 1, it means the remaining product is a prime number itself
        if (product > 1) {
            int count = 1; // exponent is 1 for this prime
            ans = (ans * nCr_mod_p(count + n - 1, n - 1)) % MOD;
        }

        return (int) ans;
    }

    private void precomputeFactorials() {
        fact[0] = 1;
        for (int i = 1; i < MAX_COMB_N; i++) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }

        // Compute inverse factorials using invFact[MAX_COMB_N-1] and then working backwards.
        // invFact[N] = (N!)^(MOD-2) (using Fermat's Little Theorem)
        // invFact[N-1] = ((N-1)!)^(MOD-2) = (N! / N)^(MOD-2) = N!^(MOD-2) * N^(MOD-2) = invFact[N] * N (mod MOD)
        invFact[MAX_COMB_N - 1] = power(fact[MAX_COMB_N - 1], MOD - 2);
        for (int i = MAX_COMB_N - 2; i >= 0; i--) { // invFact[0] is 1, (fact[0])^(MOD-2) = 1^(MOD-2) = 1
            invFact[i] = (invFact[i + 1] * (i + 1)) % MOD;
        }
    }

    // Modular exponentiation: base^exp % MOD
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

    // nCr % MOD using precomputed factorials
    private long nCr_mod_p(int n, int r) {
        if (r < 0 || r > n) return 0;
        // C(n, r) = n! / (r! * (n-r)!)
        // = fact[n] * invFact[r] * invFact[n-r] % MOD
        return (((fact[n] * invFact[r]) % MOD) * invFact[n - r]) % MOD;
    }
}