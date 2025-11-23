import java.util.Arrays;

class Solution {
    public long maximumSubarraySum(int[] nums, int k) {
        int n = nums.length;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        long maxSum = 0; 
        long[] minPrefixSum = new long[k]; 

        Arrays.fill(minPrefixSum, Long.MAX_VALUE);
        minPrefixSum[0] = 0; 

        for (int j = 0; j < n; j++) {
            long currentPrefixSum = prefixSum[j + 1];
            int remainder = (j + 1) % k;

            if (minPrefixSum[remainder] != Long.MAX_VALUE) {
                maxSum = Math.max(maxSum, currentPrefixSum - minPrefixSum[remainder]);
            }

            minPrefixSum[remainder] = Math.min(minPrefixSum[remainder], currentPrefixSum);
        }

        return maxSum;
    }
}