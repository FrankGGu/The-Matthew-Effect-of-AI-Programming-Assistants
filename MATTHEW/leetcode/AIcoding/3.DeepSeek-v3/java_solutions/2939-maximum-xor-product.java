class Solution {
    public int maximumXorProduct(long a, long b, int n) {
        long mod = 1_000_000_007;
        long x = 0;
        for (int i = n - 1; i >= 0; --i) {
            long mask = 1L << i;
            if ((a & mask) == (b & mask)) {
                x |= mask;
            } else {
                if (a > b) {
                    long temp = a;
                    a = b;
                    b = temp;
                }
                if ((a & mask) == 0 && (b & mask) != 0) {
                    a ^= mask;
                    b ^= mask;
                }
            }
        }
        return (int) ((a % mod) * (b % mod) % mod);
    }
}