class Solution {
    public int countGoodNumbers(long n) {
        long mod = 1000000007;
        long evenCount = (n + 1) / 2;
        long oddCount = n / 2;
        long evenWays = power(5, evenCount, mod);
        long oddWays = power(4, oddCount, mod);
        return (int) ((evenWays * oddWays) % mod);
    }

    private long power(long x, long y, long mod) {
        long result = 1;
        x = x % mod;
        while (y > 0) {
            if ((y & 1) == 1) {
                result = (result * x) % mod;
            }
            y = y >> 1;
            x = (x * x) % mod;
        }
        return result;
    }
}