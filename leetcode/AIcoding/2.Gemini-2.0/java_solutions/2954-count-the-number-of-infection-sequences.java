class Solution {
    private static final int MOD = 1000000007;

    public int numberOfSequence(int n, int[] sick) {
        int m = sick.length;
        int healthy = n - m;
        Arrays.sort(sick);

        long result = 1;
        for (int i = 1; i <= healthy; i++) {
            result = (result * i) % MOD;
        }

        int prev = 0;
        for (int i = 0; i < m; i++) {
            int space = sick[i] - prev - 1;
            if (space > 0) {
                result = (result * power(healthy + 1, space)) % MOD;
                healthy -= space;
            }
            prev = sick[i];
        }

        if (n - sick[m - 1] - 1 > 0) {
            result = (result * power(healthy + 1, n - sick[m - 1] - 1)) % MOD;
        }

        long comb = combination(n, m);
        result = (result * comb) % MOD;

        return (int) result;
    }

    private long power(int base, int exp) {
        long res = 1;
        long b = base;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * b) % MOD;
            }
            b = (b * b) % MOD;
            exp /= 2;
        }
        return res;
    }

    private long combination(int n, int k) {
        long[] fact = new long[n + 1];
        fact[0] = 1;
        for (int i = 1; i <= n; i++) {
            fact[i] = (fact[i - 1] * i) % MOD;
        }

        long num = fact[n];
        long den = (fact[k] * fact[n - k]) % MOD;

        return (num * modInverse(den, MOD)) % MOD;
    }

    private long modInverse(long a, int m) {
        return power(a, m - 2);
    }
}