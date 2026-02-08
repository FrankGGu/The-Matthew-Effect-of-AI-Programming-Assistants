class Solution {
    public int minNonZeroProduct(int p) {
        long mod = 1000000007;
        long max = (1L << p) - 1;
        long ans = power(max - 1, (max / 2), mod);
        ans = (ans * max) % mod;
        return (int) ans;
    }

    private long power(long base, long exp, long mod) {
        long res = 1;
        base %= mod;
        while (exp > 0) {
            if ((exp & 1) == 1) res = (res * base) % mod;
            base = (base * base) % mod;
            exp >>= 1;
        }
        return res;
    }
}