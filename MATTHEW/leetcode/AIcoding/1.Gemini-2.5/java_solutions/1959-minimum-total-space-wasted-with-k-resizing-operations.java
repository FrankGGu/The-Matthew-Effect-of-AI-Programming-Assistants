import java.util.Arrays;

class Solution {
    public int minSpaceWastedKResizing(int[] nums, int k) {
        int n = nums.length;

        // dp[i][j] represents the minimum wasted space for the first i elements (nums[0...i-1])
        // using j resizing operations.
        // i ranges from 0 to n.
        // j ranges from 0 to k.
        int[][] dp = new int[n + 1][k + 1];

        // Initialize dp table with a large value.
        // Using Integer.MAX_VALUE / 2 to prevent overflow when adding.
        for (int i = 0; i <= n; i++) {
            Arrays.fill(dp[i], Integer.MAX_VALUE / 2);
        }

        // Base case: 0 elements, 0 resizes, 0 wasted space.
        dp[0][0] = 0;

        // Iterate through the number of elements considered (from 1 to n)
        for (int i = 1; i <= n; i++) {
            // Calculate dp[i][0]: minimum waste for the first 'i' elements using 0 resizes (i.e., 1 segment).
            int currentMax = 0;
            int currentSum = 0;
            for (int idx = 0; idx < i; idx++) {
                currentMax = Math.max(currentMax, nums[idx]);
                currentSum += nums[idx];
            }
            dp[i][0] = (currentMax * i) - currentSum;

            // Iterate through the number of resizes (from 1 to k)
            for (int j = 1; j <= k; j++) {
                // To calculate dp[i][j], we consider the last segment ending at index i-1.
                // This last segment starts at index 'p', covering nums[p...i-1].
                // The elements nums[0...p-1] would have been processed with j-1 resizes.

                int maxInLastSegment = 0;
                int sumInLastSegment = 0;

                // Iterate 'p' from 'i-1' down to '0' to define the start of the last segment.
                // This allows efficient calculation of maxInLastSegment and sumInLastSegment.
                for (int p = i - 1; p >= 0; p--) {
                    maxInLastSegment = Math.max(maxInLastSegment, nums[p]);
                    sumInLastSegment += nums[p];

                    int segmentLength = i - p;
                    int wasteForLastSegment = (maxInLastSegment * segmentLength) - sumInLastSegment;

                    // If dp[p][j-1] is reachable (not Integer.MAX_VALUE / 2),
                    // update dp[i][j] with the minimum waste.
                    if (dp[p][j - 1] != Integer.MAX_VALUE / 2) {
                        dp[i][j] = Math.min(dp[i][j], dp[p][j - 1] + wasteForLastSegment);
                    }
                }
            }
        }

        // The problem states "at most k times", so we need to find the minimum waste
        // among all possible number of resizes from 0 to k for all 'n' elements.
        int minTotalWaste = Integer.MAX_VALUE / 2;
        for (int j = 0; j <= k; j++) {
            minTotalWaste = Math.min(minTotalWaste, dp[n][j]);
        }

        return minTotalWaste;
    }
}