class Solution {
    public int minimumAverageDifference(int[] nums) {
        int n = nums.length;
        long[] prefixSum = new long[n];
        prefixSum[0] = nums[0];
        for (int i = 1; i < n; i++) {
            prefixSum[i] = prefixSum[i - 1] + nums[i];
        }

        int minAvgDiffIndex = 0;
        long minAvgDiff = Long.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            long avg1 = prefixSum[i] / (i + 1);
            long avg2 = 0;
            if (i != n - 1) {
                avg2 = (prefixSum[n - 1] - prefixSum[i]) / (n - i - 1);
            }

            long currentAvgDiff = Math.abs(avg1 - avg2);

            if (currentAvgDiff < minAvgDiff) {
                minAvgDiff = currentAvgDiff;
                minAvgDiffIndex = i;
            }
        }

        return minAvgDiffIndex;
    }
}