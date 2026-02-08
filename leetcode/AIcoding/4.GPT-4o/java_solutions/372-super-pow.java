class Solution {
    public int superPow(int a, int[] b) {
        int mod = 1337;
        a %= mod;
        int result = 1;
        for (int i = 0; i < b.length; i++) {
            result = (result * pow(a, b[i], mod)) % mod;
            a = pow(a, 10, mod);
        }
        return result;
    }

    private int pow(int x, int n, int mod) {
        int res = 1;
        while (n > 0) {
            if ((n & 1) == 1) {
                res = (res * x) % mod;
            }
            x = (x * x) % mod;
            n >>= 1;
        }
        return res;
    }
}