class Solution {
    private final int MOD = 1337;

    public int superPow(int a, int[] b) {
        a %= MOD;
        return superPowRecursive(a, b, b.length - 1);
    }

    private int superPowRecursive(int a, int[] b, int index) {
        if (index < 0) {
            return 1;
        }
        return (pow(superPowRecursive(a, b, index - 1), 10) * pow(a, b[index])) % MOD;
    }

    private int pow(int base, int exp) {
        int res = 1;
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