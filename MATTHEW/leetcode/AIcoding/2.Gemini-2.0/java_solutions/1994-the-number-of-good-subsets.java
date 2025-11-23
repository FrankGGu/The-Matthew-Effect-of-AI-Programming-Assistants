class Solution {
    private static final int[] primes = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
    private static final int MOD = 1000000007;

    public int numberOfGoodSubsets(int[] nums) {
        int[] count = new int[31];
        for (int num : nums) {
            count[num]++;
        }

        long[] dp = new long[1 << 10];
        dp[0] = 1;

        for (int i = 2; i <= 30; i++) {
            if (count[i] == 0) continue;

            int mask = 0;
            int num = i;
            boolean valid = true;
            for (int j = 0; j < 10; j++) {
                if (num % primes[j] == 0) {
                    if (num % (primes[j] * primes[j]) == 0) {
                        valid = false;
                        break;
                    }
                    mask |= (1 << j);
                }
            }

            if (!valid) continue;

            for (int j = (1 << 10) - 1; j >= 0; j--) {
                if ((j & mask) == 0) {
                    dp[j | mask] = (dp[j | mask] + dp[j] * count[i]) % MOD;
                }
            }
        }

        long ans = 0;
        for (int i = 1; i < (1 << 10); i++) {
            ans = (ans + dp[i]) % MOD;
        }

        long pow2 = 1;
        for (int i = 0; i < count[1]; i++) {
            pow2 = (pow2 * 2) % MOD;
        }

        return (int) ((ans * pow2) % MOD);
    }
}