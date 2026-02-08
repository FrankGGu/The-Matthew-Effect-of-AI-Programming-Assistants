class Solution {
    public long maximumSegmentSum(int[] nums, int removeCount) {
        int n = nums.length;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        long maxSum = Long.MIN_VALUE;
        for (int i = 0; i <= removeCount; i++) {
            long currentSum = 0;
            for (int j = 0; j <= i; j++) {
                currentSum += prefixSum[j];
            }
            for (int j = n - removeCount + i; j < n; j++) {
                currentSum += prefixSum[j + 1] - prefixSum[j + 1 - (n - removeCount)];
            }
            maxSum = Math.max(maxSum, currentSum);
        }
        return maxSum;
    }
}