class Solution {
    public int maxDotProduct(int[] nums1, int[] nums2) {
        int n = nums1.length;
        int m = nums2.length;

        int[] dp = new int[m + 1];
        // Initialize dp array with a very small number to represent invalid states
        // This is crucial because subsequences must be non-empty.
        // Integer.MIN_VALUE is used to ensure that any valid dot product (even a negative one)
        // will be greater than the initial value, and also to correctly handle
        // the case where we can't extend a previous subsequence.
        for (int j = 0; j <= m; j++) {
            dp[j] = Integer.MIN_VALUE;
        }

        for (int i = 1; i <= n; i++) {
            int[] newDp = new int[m + 1];
            newDp[0] = Integer.MIN_VALUE; // No subsequence from nums2

            for (int j = 1; j <= m; j++) {
                int currentProduct = nums1[i - 1] * nums2[j - 1];

                // Option 1: Don't include nums1[i-1] in the subsequence from nums1
                // Corresponds to dp[i-1][j]
                int option1 = dp[j];

                // Option 2: Don't include nums2[j-1] in the subsequence from nums2
                // Corresponds to dp[i][j-1]
                int option2 = newDp[j - 1];

                // Option 3: Include both nums1[i-1] and nums2[j-1]
                // This can either be a new pair forming a subsequence of length 1 for both,
                // or it can extend a previous valid dot product (dp[i-1][j-1]).
                // We only extend if dp[i-1][j-1] is a valid (not MIN_VALUE) dot product.
                int option3_val = currentProduct;
                if (dp[j - 1] != Integer.MIN_VALUE) {
                    option3_val = Math.max(option3_val, dp[j - 1] + currentProduct);
                }

                // The maximum dot product for dp[i][j] is the max of these three options.
                newDp[j] = Math.max(Math.max(option1, option2), option3_val);
            }
            dp = newDp; // Update dp for the next iteration
        }

        return dp[m];
    }
}