class Solution {
    public int maximumXorProduct(long a, long b, int n) {
        long mod = 1000000007;
        if (n == 0) {
            return (int) ((a % mod) * (b % mod) % mod);
        }

        if (a == b) {
            return (int) (((a + ((1L << (n - 1)))) % mod) * ((b + ((1L << (n - 1)))) % mod) % mod);
        }

        if (a < b) {
            long temp = a;
            a = b;
            b = temp;
        }

        long diff = a - b;
        long mask = (1L << n) - 1;

        if ((diff & (1L << (n - 1))) == 0) {
            a = (a | (1L << (n - 1)));
            b = (b & (~(1L << (n - 1))));
        } else {
            a = (a & (~(1L << (n - 1))));
            b = (b | (1L << (n - 1)));
        }

        return (int) ((a % mod) * (b % mod) % mod);
    }
}