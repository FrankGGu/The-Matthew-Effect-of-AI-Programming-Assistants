import java.util.Arrays;

class Solution {
    public int numberOfGoodSubsets(int[] nums) {
        final int MOD = 1_000_000_007;

        int[] primes = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};

        int[] counts = new int[31];
        for (int num : nums) {
            counts[num]++;
        }

        int[] masks = new int[31];
        boolean[] isSquareFree = new boolean[31];
        Arrays.fill(isSquareFree, true); // Assume all are square-free initially

        for (int i = 2; i <= 30; i++) {
            int currentMask = 0;
            int temp = i;
            for (int j = 0; j < primes.length; j++) {
                int p = primes[j];
                if (temp % p == 0) {
                    if (temp % (p * p) == 0) { // If p*p is a factor, not square-free
                        isSquareFree[i] = false;
                        break;
                    }
                    currentMask |= (1 << j);
                    temp /= p;
                }
            }
            masks[i] = currentMask;
        }

        long[] dp = new long[1 << primes.length];
        dp[0] = 1; // Represents the empty set, whose product (1) is square-free

        for (int i = 2; i <= 30; i++) {
            if (counts[i] == 0 || !isSquareFree[i]) {
                continue;
            }

            int currentNumMask = masks[i];
            for (int mask = (1 << primes.length) - 1; mask >= 0; mask--) {
                // If the current number's prime factors do not conflict with the current mask
                if ((mask & currentNumMask) == 0) { 
                    // Add ways to form new mask by including current number
                    dp[mask | currentNumMask] = (dp[mask | currentNumMask] + dp[mask] * counts[i]) % MOD;
                }
            }
        }

        long totalGoodSubsetsExcludingOnes = 0;
        for (int mask = 0; mask < (1 << primes.length); mask++) {
            totalGoodSubsetsExcludingOnes = (totalGoodSubsetsExcludingOnes + dp[mask]) % MOD;
        }

        long powerOf2ForOnes = 1;
        if (counts[1] > 0) {
            for (int k = 0; k < counts[1]; k++) {
                powerOf2ForOnes = (powerOf2ForOnes * 2) % MOD;
            }
        }

        long result = (totalGoodSubsetsExcludingOnes * powerOf2ForOnes) % MOD;

        // Subtract 1 to exclude the empty set, as problem usually implies non-empty subsets
        return (int) ((result - 1 + MOD) % MOD);
    }
}