class Solution {
    private static final int MOD = 1_000_000_007;
    private static final int[] PRIMES = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};

    public int squareFreeSubsets(int[] nums) {
        int[] dp = new int[1 << PRIMES.length];
        dp[0] = 1;

        for (int num : nums) {
            int mask = getMask(num);
            if (mask == -1) continue;
            for (int i = dp.length - 1; i >= 0; i--) {
                if ((i & mask) == 0) {
                    dp[i | mask] = (dp[i | mask] + dp[i]) % MOD;
                }
            }
        }

        int total = 0;
        for (int count : dp) {
            total = (total + count) % MOD;
        }
        return (total - 1 + MOD) % MOD;
    }

    private int getMask(int num) {
        int mask = 0;
        for (int i = 0; i < PRIMES.length; i++) {
            int prime = PRIMES[i];
            if (num % (prime * prime) == 0) {
                return -1;
            }
            if (num % prime == 0) {
                mask |= 1 << i;
            }
        }
        return mask;
    }
}