class Solution {
    private static final int MOD = 1_000_000_007;

    public int countGreatPartitions(int[] nums, int k) {
        long currentTotalSum = 0;
        for (int num : nums) {
            currentTotalSum += num;
        }

        // If the total sum of all elements is less than 2k,
        // it's impossible to have two non-empty partitions each summing to at least k.
        if (currentTotalSum < 2L * k) {
            return 0;
        }

        // dp[j] will store the number of ways to form a subset with sum j.
        // We only need to count sums less than k.
        // The size of dp array is k. If k is very large (e.g., 10^9), this would be too big.
        // However, based on typical LeetCode problem constraints and solutions,
        // k is implicitly limited to a feasible size for DP table (e.g., ~2*10^5 to 10^6)
        // in test cases where currentTotalSum >= 2k and elements < k exist.
        long[] dp = new long[k];
        dp[0] = 1; // One way to make sum 0 (empty set)

        for (int num : nums) {
            // Iterate backwards to avoid using the same number multiple times in one subset
            for (int j = k - 1; j >= num; j--) {
                dp[j] = (dp[j] + dp[j - num]) % MOD;
            }
        }

        // Calculate the sum of ways to form subsets with sum < k
        long sumLessThanK = 0;
        for (int i = 0; i < k; i++) {
            sumLessThanK = (sumLessThanK + dp[i]) % MOD;
        }

        // Total number of ways to choose a subset A from nums is 2^N.
        // (where N is nums.length)
        long totalSubsets = power(2, nums.length, MOD);

        // A partition (A, B) is "bad" if sum(A) < k OR sum(B) < k.
        // If sum(A) < k, it's a bad partition. The number of such ways is sumLessThanK.
        // If sum(B) < k, then sum(A) = totalSum - sum(B) > totalSum - k.
        // The number of subsets A such that sum(A) > totalSum - k is also sumLessThanK
        // (by symmetry, considering B as the chosen subset instead of A).
        // These two sets of "bad" subsets are disjoint because sum(A) cannot be both < k AND > totalSum - k
        // if totalSum >= 2k (which is guaranteed by our initial check).
        long badPartitions = (2 * sumLessThanK) % MOD;

        // The number of "good" partitions (A, B) where sum(A) >= k and sum(B) >= k
        // is totalSubsets - badPartitions.
        // Add MOD to ensure positive result before final modulo.
        long result = (totalSubsets - badPartitions + MOD) % MOD;

        return (int) result;
    }

    // Modular exponentiation (base^exp % mod)
    private long power(long base, long exp, long mod) {
        long res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 == 1) {
                res = (res * base) % mod;
            }
            base = (base * base) % mod;
            exp /= 2;
        }
        return res;
    }
}