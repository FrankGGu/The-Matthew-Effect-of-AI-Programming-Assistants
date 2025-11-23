class Solution {
    private static final int MOD = 1_000_000_007;

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

    public int monkeyCollision(int n) {
        long totalWays = power(2, n);
        long collisionWays = (totalWays - 2 + MOD) % MOD;

        return (int) collisionWays;
    }
}