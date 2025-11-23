class Solution {
    public int findSumOfArrayProductOfMagicalSequences(int[] nums, int k) {
        int n = nums.length;
        long MOD = 1_000_000_007;

        // dp[i][j] will store the sum of products of subsequences of length j
        // considering elements from nums[0] up to nums[i-1].
        // The table size is (n + 1) x (k + 1).
        long[][] dp = new long[n + 1][k + 1];

        // Base case: There is one way to form an empty subsequence (length 0),
        // and its product is considered 1.
        // This holds true regardless of how many elements we consider from nums.
        for (int i = 0; i <= n; i++) {
            dp[i][0] = 1;
        }

        // Iterate through each number in the input array nums.
        // 'i' represents the count of elements considered from nums (nums[0]...nums[i-1]).
        for (int i = 1; i <= n; i++) {
            // Iterate through possible subsequence lengths from 1 up to k.
            for (int j = 1; j <= k; j++) {
                // Option 1: Do not include the current number (nums[i-1]) in the subsequence.
                // In this case, the sum of products is the same as considering elements
                // up to nums[i-2] for a subsequence of length j.
                dp[i][j] = dp[i-1][j];

                // Option 2: Include the current number (nums[i-1]) in the subsequence.
                // To form a subsequence of length j including nums[i-1],
                // we need to have formed a subsequence of length j-1 from the elements
                // before nums[i-1] (i.e., nums[0]...nums[i-2]).
                // We then multiply the sum of products of those (j-1)-length subsequences
                // by the current number nums[i-1].

                // Calculate the term for including nums[i-1].
                // Ensure intermediate products and sums are taken modulo MOD.
                // Add MOD before taking modulo to handle potential negative results from multiplication
                // if nums[i-1] is negative (Java's % operator can return negative results for negative dividends).
                long term = (dp[i-1][j-1] * nums[i-1]) % MOD;

                // Add this term to dp[i][j]. Again, ensure the result is positive.
                dp[i][j] = (dp[i][j] + term + MOD) % MOD;
            }
        }

        // The final answer is the sum of products of all subsequences of length k
        // considering all elements from nums[0] to nums[n-1].
        return (int) dp[n][k];
    }
}