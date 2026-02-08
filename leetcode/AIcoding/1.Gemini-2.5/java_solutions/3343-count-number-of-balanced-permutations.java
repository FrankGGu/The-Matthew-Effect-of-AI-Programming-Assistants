class Solution {
    private static final int MOD = 1_000_000_007;

    public int countBalancedPermutations(int n) {
        if (n == 0) {
            return 1;
        }

        long factorial2n = 1;
        for (int i = 1; i <= 2 * n; i++) {
            factorial2n = (factorial2n * i) % MOD;
        }

        long invNPlus1 = power(n + 1, MOD - 2);

        long result = (factorial2n * invNPlus1) % MOD;

        return (int) result;
    }

    private long power(long base, long exp) {
        long res = 1;
        base %= MOD;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % MOD;
            }
            base = (base * base) % MOD;
            exp /= 2;
        }
        return res;
    }
}