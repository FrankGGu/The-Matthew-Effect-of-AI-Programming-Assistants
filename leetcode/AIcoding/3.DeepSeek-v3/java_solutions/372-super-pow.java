class Solution {
    private static final int MOD = 1337;

    public int superPow(int a, int[] b) {
        if (b == null || b.length == 0) return 1;
        a %= MOD;
        int res = 1;
        for (int i = 0; i < b.length; i++) {
            res = pow(res, 10) * pow(a, b[i]) % MOD;
        }
        return res;
    }

    private int pow(int x, int n) {
        if (n == 0) return 1;
        if (n == 1) return x % MOD;
        int half = pow(x, n / 2);
        if (n % 2 == 0) {
            return half * half % MOD;
        } else {
            return half * half % MOD * x % MOD;
        }
    }
}