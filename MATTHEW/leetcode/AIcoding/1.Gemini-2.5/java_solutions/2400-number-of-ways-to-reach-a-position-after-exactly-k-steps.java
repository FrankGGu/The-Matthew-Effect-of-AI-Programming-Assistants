class Solution {
    private static final int MOD = 1_000_000_007;
    private long[] fact;

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

    private long nCr(int n, int r) {
        if (r < 0 || r > n) {
            return 0;
        }
        if (r == 0 || r == n) {
            return 1;
        }

        long numerator = fact[n];
        long denominator = (fact[r] * fact[n - r]) % MOD;
        return (numerator * modInverse(denominator)) % MOD;
    }

    public int numberOfWays(int startPos, int endPos, int k) {
        fact = new long[k + 1];
        fact[0] = 1;
        for (int i = 1; i <= k; i++) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }

        int diff = endPos - startPos;

        // Let p be the number of positive steps (+1) and m be the number of negative steps (-1).
        // We have two equations:
        // 1) p + m = k (total steps)
        // 2) startPos + p - m = endPos  =>  p - m = diff
        //
        // Adding (1) and (2):
        // 2p = k + diff  =>  p = (k + diff) / 2
        //
        // Subtracting (2) from (1):
        // 2m = k - diff  =>  m = (k - diff) / 2
        //
        // For p and m to be valid counts of steps, they must satisfy:
        // 1. p >= 0
        // 2. m >= 0 (which implies p <= k)
        // 3. p must be an integer
        // 4. m must be an integer (if p is an integer, and k is an integer, m will also be an integer)
        //
        // From p = (k + diff) / 2:
        // Condition 1: k + diff >= 0
        // Condition 3: k + diff must be an even number
        //
        // From m = (k - diff) / 2:
        // Condition 2: k - diff >= 0  =>  k >= diff
        //
        // Combining these, we need:
        // (k + diff) >= 0
        // (k + diff) % 2 == 0
        // p = (k + diff) / 2
        // p <= k (which is equivalent to diff <= k)

        if ((k + diff) < 0 || (k + diff) % 2 != 0) {
            return 0;
        }

        int p = (k + diff) / 2;

        if (p > k) { 
            return 0;
        }

        return (int) nCr(k, p);
    }
}