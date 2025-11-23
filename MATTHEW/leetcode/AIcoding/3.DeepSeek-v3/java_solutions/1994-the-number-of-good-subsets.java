class Solution {
    private static final int MOD = 1_000_000_007;
    private static final int[] PRIMES = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
    private static final int NUM_PRIMES = PRIMES.length;

    public int numberOfGoodSubsets(int[] nums) {
        int[] freq = new int[31];
        for (int num : nums) {
            freq[num]++;
        }

        int[] dp = new int[1 << NUM_PRIMES];
        dp[0] = 1;

        for (int i = 0; i < freq[1]; i++) {
            dp[0] = (dp[0] * 2) % MOD;
        }

        for (int num = 2; num <= 30; num++) {
            if (freq[num] == 0) {
                continue;
            }

            int subset = 0;
            boolean valid = true;
            for (int j = 0; j < NUM_PRIMES; j++) {
                if (num % (PRIMES[j] * PRIMES[j]) == 0) {
                    valid = false;
                    break;
                }
                if (num % PRIMES[j] == 0) {
                    subset |= (1 << j);
                }
            }

            if (!valid) {
                continue;
            }

            for (int mask = (1 << NUM_PRIMES) - 1; mask >= 0; mask--) {
                if ((mask & subset) == subset) {
                    dp[mask] = (int) ((dp[mask] + (long) dp[mask ^ subset] * freq[num]) % MOD);
                }
            }
        }

        int res = 0;
        for (int mask = 1; mask < (1 << NUM_PRIMES); mask++) {
            res = (res + dp[mask]) % MOD;
        }
        return res;
    }
}