class Solution {
    private static final int MOD = 1_000_000_007;

    public int minSum(int n, int k) {
        long q = k / n; // number of times each element is multiplied by 2, at a minimum
        long r = k % n; // number of elements that get an additional multiplication by 2

        // (n - r) elements will be multiplied q times, resulting in 2^q
        // r elements will be multiplied (q + 1) times, resulting in 2^(q+1)

        long countForQ = n - r;
        long countForQPlus1 = r;

        long powerOf2_q = power(2, q);
        long powerOf2_qPlus1 = power(2, q + 1);

        long sum = (countForQ * powerOf2_q) % MOD;
        sum = (sum + (countForQPlus1 * powerOf2_qPlus1) % MOD) % MOD;

        return (int) sum;
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