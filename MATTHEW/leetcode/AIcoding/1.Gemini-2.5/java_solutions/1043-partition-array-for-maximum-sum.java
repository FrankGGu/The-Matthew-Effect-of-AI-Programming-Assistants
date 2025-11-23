class Solution {
    public int maxSumAfterPartitioning(int[] arr, int k) {
        int n = arr.length;
        int[] dp = new int[n + 1]; // dp[i] stores the maximum sum for the subarray arr[0...i-1]

        for (int i = 1; i <= n; i++) {
            int currentMax = 0;
            // j represents the length of the last partition
            // The last partition is arr[i-j ... i-1]
            for (int j = 1; j <= k && i - j >= 0; j++) {
                // arr[i-j] is the leftmost element of the current partition of length j
                currentMax = Math.max(currentMax, arr[i - j]);
                // dp[i-j] is the max sum for the prefix before this partition
                dp[i] = Math.max(dp[i], dp[i - j] + currentMax * j);
            }
        }

        return dp[n];
    }
}