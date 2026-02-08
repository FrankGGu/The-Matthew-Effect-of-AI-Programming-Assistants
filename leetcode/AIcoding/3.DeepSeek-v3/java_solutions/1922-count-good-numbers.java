class Solution {
    private static final int MOD = 1_000_000_007;

    public int countGoodNumbers(long n) {
        long even = (n + 1) / 2;
        long odd = n / 2;
        long evenCount = pow(5, even);
        long oddCount = pow(4, odd);
        return (int) ((evenCount * oddCount) % MOD);
    }

    private long pow(long x, long n) {
        if (n == 0) {
            return 1;
        }
        long temp = pow(x, n / 2);
        if (n % 2 == 0) {
            return (temp * temp) % MOD;
        } else {
            return (x * temp * temp) % MOD;
        }
    }
}