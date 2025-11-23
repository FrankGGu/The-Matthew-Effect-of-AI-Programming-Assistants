class Solution {
    private static final int MOD = 1_000_000_007;
    private long[] fact;

    public int solve(int n, int k) {
        if (k < 2) {
            return 0;
        }

        long nLong = n;
        long nSq = nLong * nLong;

        // Calculate the sum of Manhattan distances between all UNORDERED pairs of distinct cells.
        // Sum_{ {P1, P2} where P1 != P2 } (|r1 - r2| + |c1 - c2|)
        // This sum simplifies to n^3 * (n^2-1) / 3

        long sumDistancesFactor;

        long term1 = nLong % MOD;
        term1 = (term1 * nLong) % MOD; 
        term1 = (term1 * nLong) % MOD; // n^3 % MOD

        long term2 = (nLong * nLong) % MOD; 
        term2 = (term2 - 1 + MOD) % MOD; // (n^2 - 1) % MOD

        sumDistancesFactor = (term1 * term2) % MOD;

        long inv3 = power(3, MOD - 2);
        sumDistancesFactor = (sumDistancesFactor * inv3) % MOD;

        // Calculate C(n*n - 2, k-2)
        int N_total_cells = (int)nSq;

        // Precompute factorials up to N_total_cells
        // Max N_total_cells is 30*30 = 900
        fact = new long[N_total_cells + 1];
        fact[0] = 1;
        for (int i = 1; i <= N_total_cells; i++) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }

        long combinationsFactor = combinations(N_total_cells - 2, k - 2);

        long finalResult = (sumDistancesFactor * combinationsFactor) % MOD;

        return (int) finalResult;
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

    private long modInverse(long n) {
        return power(n, MOD - 2);
    }

    private long combinations(int N, int K) {
        if (K < 0 || K > N) {
            return 0;
        }
        long numerator = fact[N];
        long denominator = (fact[K] * fact[N - K]) % MOD;
        return (numerator * modInverse(denominator)) % MOD;
    }
}