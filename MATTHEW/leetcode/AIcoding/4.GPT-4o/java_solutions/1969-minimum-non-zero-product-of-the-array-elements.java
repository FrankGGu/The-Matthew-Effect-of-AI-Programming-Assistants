class Solution {
    public int minNonZeroProduct(int p) {
        long mod = 1000000007;
        long maxOdd = (1L << p) - 1;
        long result = modPow(maxOdd % mod, (1L << (p - 1)) % (mod - 1), mod);
        return (int) ((result * (maxOdd % mod)) % mod);
    }

    private long modPow(long base, long exp, long mod) {
        long result = 1;
        while (exp > 0) {
            if ((exp & 1) == 1) {
                result = (result * base) % mod;
            }
            base = (base * base) % mod;
            exp >>= 1;
        }
        return result;
    }
}