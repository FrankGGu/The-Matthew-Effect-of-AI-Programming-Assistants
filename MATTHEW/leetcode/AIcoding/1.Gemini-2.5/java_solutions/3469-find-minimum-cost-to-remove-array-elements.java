class Solution {
    public int minCostToRemoveArrayElements(int[] nums) {
        int n = nums.length;
        if (n == 0) {
            return 0;
        }

        // dp[i][j] represents the minimum cost to remove the subarray nums[i...j]
        // The cost model assumed: Removing a contiguous subarray of identical elements costs 1.
        int[][] dp = new int[n][n];

        // Base case: To remove a single element subarray nums[i...i], the cost is 1.
        for (int i = 0; i < n; i++) {
            dp[i][i] = 1;
        }

        // Fill dp table for lengths from 2 to n
        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;

                // Option 1: Remove nums[i] as a single-element block.
                // The cost is 1 (for nums[i]) + the minimum cost to remove the remaining subarray nums[i+1...j].
                dp[i][j] = 1 + dp[i + 1][j];

                // Option 2: Try to find an element nums[k] (where k > i) such that nums[k] == nums[i].
                // If such a k exists, we can potentially remove nums[i] and nums[k] as part of the same block.
                // To do this, we must first remove the subarray nums[i+1...k-1] (elements between i and k).
                // The cost for this is dp[i+1][k-1].
                // After removing nums[i+1...k-1], nums[i] and nums[k] become effectively adjacent.
                // The problem then reduces to removing nums[k...j], where nums[k] is now the effective start.
                // The cost for this is dp[k][j].
                // The combined cost is dp[i+1][k-1] + dp[k][j].
                // Note: If k == i + 1, then nums[i+1...k-1] is an empty subarray, and dp[i+1][k-1] (i.e., dp[i+1][i]) will be 0 by default initialization.
                for (int k = i + 1; k <= j; k++) {
                    if (nums[k] == nums[i]) {
                        int cost = dp[i + 1][k - 1] + dp[k][j];
                        dp[i][j] = Math.min(dp[i][j], cost);
                    }
                }
            }
        }

        // The minimum cost to remove the entire array is dp[0][n-1].
        return dp[0][n - 1];
    }
}