class Solution {
    public double largestSumOfAverages(int[] nums, int k) {
        int n = nums.length;

        // prefixSum[i] stores the sum of nums[0] to nums[i-1]
        double[] prefixSum = new double[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        // dp[j][i] stores the maximum sum of averages for the first 'i' elements
        // using 'j' partitions.
        double[][] dp = new double[k + 1][n + 1];

        // Base case: j = 1 partition
        // For 1 partition, the average is simply the sum of elements divided by their count.
        for (int i = 1; i <= n; i++) {
            dp[1][i] = prefixSum[i] / i;
        }

        // Fill the dp table for j from 2 to k
        for (int j = 2; j <= k; j++) {
            // For each number of elements 'i' (from 1 to n)
            for (int i = 1; i <= n; i++) {
                // If 'i' elements are not enough to form 'j' partitions, skip
                if (i < j) {
                    continue;
                }

                // Iterate over all possible split points 'p' for the (j-1)-th partition
                // 'p' represents the number of elements used for the first (j-1) partitions.
                // The current (j-th) partition will be nums[p ... i-1].
                // 'p' must be at least 'j-1' (each of the first j-1 partitions needs at least one element).
                // 'p' must be less than 'i' (the current j-th partition needs at least one element).
                for (int p = j - 1; p < i; p++) {
                    double currentSegmentSum = prefixSum[i] - prefixSum[p];
                    double currentSegmentLength = i - p;
                    double currentAverage = currentSegmentSum / currentSegmentLength;

                    dp[j][i] = Math.max(dp[j][i], dp[j - 1][p] + currentAverage);
                }
            }
        }

        return dp[k][n];
    }
}