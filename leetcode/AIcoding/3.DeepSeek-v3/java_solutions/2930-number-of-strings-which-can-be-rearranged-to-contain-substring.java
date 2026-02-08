class Solution {
    private static final int MOD = 1_000_000_007;

    public int stringCount(int n) {
        if (n < 4) return 0;
        long total = pow(26, n);
        long noL = pow(25, n);
        long noT = pow(25, n);
        long noE = pow(25, n);
        long noLAndNoT = pow(24, n);
        long noLAndNoE = pow(24, n);
        long noTAndNoE = pow(24, n);
        long noLAndNoTAndNoE = pow(23, n);

        long invalid = (noL + noT + noE - noLAndNoT - noLAndNoE - noTAndNoE + noLAndNoTAndNoE) % MOD;
        long result = (total - invalid) % MOD;
        return (int) (result < 0 ? result + MOD : result);
    }

    private long pow(int base, int exponent) {
        long result = 1;
        for (int i = 0; i < exponent; i++) {
            result = (result * base) % MOD;
        }
        return result;
    }
}