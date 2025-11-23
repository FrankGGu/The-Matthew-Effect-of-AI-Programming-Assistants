import java.util.HashMap;
import java.util.Map;

class Solution {
    public int countSubMultisets(int[] nums, int lower, int upper) {
        final int MOD = 1_000_000_007;

        // Step 1: Count frequencies of each number
        Map<Integer, Integer> counts = new HashMap<>();
        for (int num : nums) {
            counts.put(num, counts.getOrDefault(num, 0) + 1);
        }

        // dp[s] will store the number of sub-multisets that sum up to s
        // dp array size should be upper + 1
        int[] dp = new int[upper + 1];
        dp[0] = 1; // There is one way to make sum 0 (by choosing an empty sub-multiset)

        // Handle 0 separately as it doesn't change the sum but adds ways to form existing sums
        if (counts.containsKey(0)) {
            // If 0 is present with 'zeroCount' occurrences, we can choose 0, 1, ..., zeroCount zeros.
            // This means for any sum 's' that can be formed by non-zero numbers,
            // it can be formed in (zeroCount + 1) ways by choosing different counts of 0s.
            // This effectively multiplies all current dp[s] values by (zeroCount + 1).
            int zeroCount = counts.get(0);
            for (int s = 0; s <= upper; s++) {
                dp[s] = (int) ((long) dp[s] * (zeroCount + 1) % MOD);
            }
            counts.remove(0); // Remove 0 from map to process other numbers
        }

        // Iterate through unique numbers from 1 to 50
        for (int num = 1; num <= 50; num++) {
            if (!counts.containsKey(num)) {
                continue;
            }
            int freq = counts.get(num);

            // Iterate 's' downwards to ensure dp[s] refers to the state before processing 'num'.
            // This prevents using the current 'num' multiple times within the same 'num' iteration
            // when calculating dp[s + k*num] from dp[s].
            for (int s = upper; s >= 0; s--) {
                if (dp[s] == 0) { // Optimization: if sum 's' cannot be formed, no need to extend it
                    continue;
                }
                // Try adding k copies of 'num' to current sum 's'
                for (int k = 1; k <= freq; k++) {
                    if (s + k * num <= upper) {
                        dp[s + k * num] = (dp[s + k * num] + dp[s]) % MOD;
                    } else {
                        // If s + k*num exceeds upper, then s + (k+1)*num will also exceed upper.
                        // So, we can break the inner loop.
                        break;
                    }
                }
            }
        }

        // Step 3: Sum up dp values within the range [lower, upper]
        long totalCount = 0;
        for (int s = lower; s <= upper; s++) {
            totalCount = (totalCount + dp[s]) % MOD;
        }

        return (int) totalCount;
    }
}