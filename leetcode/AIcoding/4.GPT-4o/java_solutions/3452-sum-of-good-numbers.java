class Solution {
    public int sumOfGoodNumbers(int n) {
        long mod = 1000000007;
        long even = (n + 1) / 2;
        long odd = n / 2;
        return (int) ((power(5, even) * power(4, odd)) % mod);
    }

    private long power(long x, long y) {
        long res = 1;
        while (y > 0) {
            if ((y & 1) == 1) {
                res = (res * x) % 1000000007;
            }
            x = (x * x) % 1000000007;
            y >>= 1;
        }
        return res;
    }
}