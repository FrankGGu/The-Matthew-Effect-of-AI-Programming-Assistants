class Solution {
    private static final int MOD = 1000000007;

    public int countGoodNumbers(long n) {
        long evenPlaces = (n + 1) / 2;
        long oddPlaces = n / 2;

        long result = (power(5, evenPlaces) * power(4, oddPlaces)) % MOD;
        return (int) result;
    }

    private long power(long base, long exponent) {
        long res = 1;
        base %= MOD;
        while (exponent > 0) {
            if (exponent % 2 == 1) res = (res * base) % MOD;
            base = (base * base) % MOD;
            exponent /= 2;
        }
        return res;
    }
}