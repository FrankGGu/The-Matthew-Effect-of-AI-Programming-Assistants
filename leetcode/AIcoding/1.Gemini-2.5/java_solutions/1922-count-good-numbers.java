class Solution {
    private final int MOD = 1_000_000_007;

    public int countGoodNumbers(long n) {
        long numEvenPositions = (n + 1) / 2;
        long numOddPositions = n / 2;

        long ans = (power(5, numEvenPositions) * power(4, numOddPositions)) % MOD;
        return (int) ans;
    }

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
}