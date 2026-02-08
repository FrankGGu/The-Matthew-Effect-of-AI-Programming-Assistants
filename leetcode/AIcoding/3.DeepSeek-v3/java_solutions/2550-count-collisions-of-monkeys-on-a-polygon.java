class Solution {
    public int monkeyMove(int n) {
        int mod = 1000000007;
        long res = powMod(2, n, mod);
        res = (res - 2 + mod) % mod;
        return (int) res;
    }

    private long powMod(long base, int exp, int mod) {
        long result = 1;
        base = base % mod;
        while (exp > 0) {
            if (exp % 2 == 1) {
                result = (result * base) % mod;
            }
            base = (base * base) % mod;
            exp = exp / 2;
        }
        return result;
    }
}