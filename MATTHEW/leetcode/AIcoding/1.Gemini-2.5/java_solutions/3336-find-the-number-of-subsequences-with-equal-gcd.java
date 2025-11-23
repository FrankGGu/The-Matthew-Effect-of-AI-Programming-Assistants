import java.util.Arrays;

class Solution {
    public int findSubsequencesWithEqualGCD(int[] nums, int k) {
        int maxValInNums = 0;
        for (int num : nums) {
            maxValInNums = Math.max(maxValInNums, num);
        }

        // max_b_val is the maximum possible value for b = num / k
        // for num in nums that are multiples of k.
        // If maxValInNums < k, then max_b_val will be 0.
        int max_b_val = maxValInNums / k;

        // If max_b_val is 0, it means no number in nums is a multiple of k (or no num >= k).
        // In this case, no k-subsequences can be formed.
        if (max_b_val == 0) {
            return 0;
        }

        // counts[b] stores the frequency of b in the transformed array B
        // where B contains num / k for all num in nums that are multiples of k.
        // Size is max_b_val + 1 to include max_b_val itself.
        int[] counts = new int[max_b_val + 1];
        for (int num : nums) {
            if (num % k == 0) {
                int b = num / k;
                // b must be <= max_b_val by definition.
                counts[b]++;
            }
        }

        // dp[g] will store the number of subsequences from B whose GCD is exactly g.
        // We want to find dp[1].
        // Use long to avoid overflow during (1L << N) - 1 calculation and intermediate subtractions.
        long[] dp = new long[max_b_val + 1];

        // Iterate from max_b_val down to 1
        for (int g = max_b_val; g >= 1; g--) {
            long numElementsMultipleOfG = 0;
            // Calculate the total count of elements in B that are multiples of g
            for (int j = g; j <= max_b_val; j += g) {
                numElementsMultipleOfG += counts[j];
            }

            if (numElementsMultipleOfG > 0) {
                // Total subsequences formed from elements that are multiples of g
                // is (2^N - 1), where N is numElementsMultipleOfG.
                // The problem implies that N will be small enough such that (1L << N) - 1
                // does not overflow a long, and the final result dp[1] fits in an int.
                dp[g] = (1L << numElementsMultipleOfG) - 1;
            }

            // Subtract subsequences whose GCD is a multiple of g, but strictly greater than g.
            // These are already counted in dp[g] but should be attributed to their exact GCD.
            for (int j = 2 * g; j <= max_b_val; j += g) {
                dp[g] -= dp[j];
            }
        }

        // The problem asks for an 'int' return type.
        // This implies that the final result dp[1] will fit within Integer.MAX_VALUE.
        return (int) dp[1];
    }
}