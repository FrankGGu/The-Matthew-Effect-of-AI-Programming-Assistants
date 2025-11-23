class Solution {
    private static final int MOD = 1000000007;

    public int monkeyMove(int n) {
        long result = 1;
        long base = 2;
        long power = n;

        while (power > 0) {
            if (power % 2 == 1) {
                result = (result * base) % MOD;
            }
            base = (base * base) % MOD;
            power /= 2;
        }

        return (int) ((result - 2 + MOD) % MOD);
    }
}