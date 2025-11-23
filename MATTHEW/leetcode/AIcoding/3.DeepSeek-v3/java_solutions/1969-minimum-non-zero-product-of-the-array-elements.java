class Solution {
    private static final long MOD = 1_000_000_007;

    public int minNonZeroProduct(int p) {
        if (p == 1) {
            return 1;
        }
        long max = (1L << p) - 1;
        long power = pow(max - 1, (max - 1) / 2);
        return (int) ((max % MOD) * (power % MOD) % MOD);
    }

    private long pow(long base, long exponent) {
        long result = 1;
        while (exponent > 0) {
            if ((exponent & 1) == 1) {
                result = (result * base) % MOD;
            }
            base = (base * base) % MOD;
            exponent >>= 1;
        }
        return result;
    }
}