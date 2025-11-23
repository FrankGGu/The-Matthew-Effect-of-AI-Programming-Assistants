class Solution {
    private static final int MOD = 1337;

    public int superPow(int a, int[] b) {
        int result = 1;
        a %= MOD;
        for (int i = 0; i < b.length; i++) {
            result = pow(result, 10) * pow(a, b[i]) % MOD;
            result %= MOD;
        }
        return result;
    }

    private int pow(int base, int exponent) {
        int result = 1;
        base %= MOD;
        while (exponent > 0) {
            if (exponent % 2 == 1) {
                result = (result * base) % MOD;
            }
            base = (base * base) % MOD;
            exponent /= 2;
        }
        return result;
    }
}