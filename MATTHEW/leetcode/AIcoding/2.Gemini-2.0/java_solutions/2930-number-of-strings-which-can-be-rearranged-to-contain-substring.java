class Solution {
    private static final int MOD = 1000000007;

    public int stringCount(int n) {
        long total = power(26, n);
        long noL = power(25, n);
        long noE = power(25, n);
        long noT = power(25, n);
        long noLE = power(24, n);
        long noLT = power(24, n);
        long noET = power(24, n);
        long noLET = power(23, n);

        long result = (total - noL - noE - noT + noLE + noLT + noET - noLET) % MOD;
        if (result < 0) {
            result += MOD;
        }
        return (int) result;
    }

    private long power(int base, int exp) {
        long res = 1;
        long b = base;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * b) % MOD;
            }
            b = (b * b) % MOD;
            exp /= 2;
        }
        return res;
    }
}