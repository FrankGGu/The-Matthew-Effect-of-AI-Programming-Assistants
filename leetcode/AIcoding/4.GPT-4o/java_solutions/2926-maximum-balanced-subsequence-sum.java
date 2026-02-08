class Solution {
    public int maximumBalancedSum(int[] nums) {
        int n = nums.length;
        int[] prefixSum = new int[n + 1];
        int[] suffixSum = new int[n + 1];

        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }
        for (int i = n - 1; i >= 0; i--) {
            suffixSum[i] = suffixSum[i + 1] + nums[i];
        }

        int maxSum = 0;
        for (int i = 0; i < n; i++) {
            if (i > 0 && nums[i] >= nums[i - 1]) {
                maxSum = Math.max(maxSum, prefixSum[i] + suffixSum[i + 1]);
            }
        }
        return maxSum;
    }
}