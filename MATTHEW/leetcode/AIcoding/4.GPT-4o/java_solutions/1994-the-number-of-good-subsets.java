import java.util.HashMap;

class Solution {
    public int numberOfGoodSubsets(int[] nums) {
        int MOD = 1_000_000_007;
        int[] count = new int[31];
        for (int num : nums) {
            count[num]++;
        }

        if (count[1] > 0) {
            count[1] = 1; // Treat 1 specially
        }

        int result = 1;
        for (int i = 2; i <= 30; i++) {
            if (count[i] > 0) {
                if (i == 6 || i == 10 || i == 14 || i == 15 || i == 21 || i == 22 || i == 26 || i == 30) {
                    return 0; // Contains primes or products of primes
                }
                result = (result * (pow(2, count[i], MOD))) % MOD;
            }
        }

        return (result - 1 + MOD) % MOD; // Subtract empty subset
    }

    private long pow(int base, int exp, int mod) {
        long result = 1;
        long b = base;
        while (exp > 0) {
            if ((exp & 1) == 1) {
                result = (result * b) % mod;
            }
            b = (b * b) % mod;
            exp >>= 1;
        }
        return result;
    }
}