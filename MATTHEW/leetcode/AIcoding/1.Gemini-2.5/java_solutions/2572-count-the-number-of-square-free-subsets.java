import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int squareFreeSubsets(int[] nums) {
        int MOD = 1_000_000_007;

        int[] primes = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
        Map<Integer, Integer> primeToIdx = new HashMap<>();
        for (int i = 0; i < primes.length; i++) {
            primeToIdx.put(primes[i], i);
        }

        // numData[i][0] = 1 if i is square-free, -1 otherwise
        // numData[i][1] = prime mask for i if square-free
        int[][] numData = new int[31][2];
        for (int i = 1; i <= 30; i++) {
            if (i == 1) {
                numData[i][0] = 1; // 1 is square-free, mask 0
                numData[i][1] = 0;
                continue;
            }

            int temp = i;
            int currentMask = 0;
            boolean isSquareFree = true;
            for (int p : primes) {
                if (temp % p == 0) {
                    currentMask |= (1 << primeToIdx.get(p));
                    temp /= p;
                    if (temp % p == 0) { // Divisible by p^2
                        isSquareFree = false;
                        break;
                    }
                }
            }
            if (isSquareFree) {
                numData[i][0] = 1;
                numData[i][1] = currentMask;
            } else {
                numData[i][0] = -1; // Not square-free
            }
        }

        int[] counts = new int[31];
        int countOnes = 0;
        for (int num : nums) {
            if (num == 1) {
                countOnes++;
            } else if (numData[num][0] == 1) { // Check if square-free
                counts[num]++;
            }
        }

        long[] dp = new long[1 << primes.length];
        dp[0] = 1; // Represents the empty set, product 1 (square-free)

        for (int i = 2; i <= 30; i++) {
            if (counts[i] > 0) { // If this square-free number exists in nums
                int currentMask = numData[i][1];
                for (int mask = (1 << primes.length) - 1; mask >= 0; mask--) {
                    if (dp[mask] > 0) {
                        if ((mask & currentMask) == 0) { // If no common prime factors
                            dp[mask | currentMask] = (dp[mask | currentMask] + dp[mask] * counts[i]) % MOD;
                        }
                    }
                }
            }
        }

        long totalSubsetsWithoutOnes = 0;
        for (long val : dp) {
            totalSubsetsWithoutOnes = (totalSubsetsWithoutOnes + val) % MOD;
        }

        // Account for the number 1s
        long pow2Ones = 1;
        for (int i = 0; i < countOnes; i++) {
            pow2Ones = (pow2Ones * 2) % MOD;
        }

        // Total subsets including empty set and 1s
        // Each of the `totalSubsetsWithoutOnes` (which includes the empty set from non-1s)
        // can be combined with any of the 2^countOnes ways to choose 1s.
        long ans = (totalSubsetsWithoutOnes * pow2Ones) % MOD;

        // Subtract 1 for the empty set itself, as the problem usually doesn't count it.
        // E.g., for nums = [3,4,4,5], expected output is 3. Our current ans would be 4.
        ans = (ans - 1 + MOD) % MOD;

        return (int) ans;
    }
}