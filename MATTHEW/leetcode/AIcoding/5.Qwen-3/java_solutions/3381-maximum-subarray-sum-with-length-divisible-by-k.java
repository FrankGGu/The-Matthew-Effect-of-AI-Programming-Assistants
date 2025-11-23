public class Solution {
    public int maximumSubarraySum(int[] nums, int k) {
        int n = nums.length;
        int maxSum = Integer.MIN_VALUE;
        int currentSum = 0;
        int[] prefixMod = new int[k];

        for (int i = 0; i < n; i++) {
            currentSum += nums[i];
            if (i >= k) {
                currentSum -= nums[i - k];
            }
            if (i >= k - 1) {
                int mod = currentSum % k;
                if (mod < 0) mod += k;
                if (prefixMod[mod] == 0) {
                    prefixMod[mod] = currentSum;
                } else {
                    maxSum = Math.max(maxSum, currentSum - prefixMod[mod]);
                }
            }
        }

        return maxSum;
    }
}