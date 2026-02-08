class Solution {
    public long maximumSubarraySum(int[] nums, int val) {
        long maxSum = 0, currentSum = 0;
        for (int num : nums) {
            if (num == val) {
                currentSum = 0;
            } else {
                currentSum += num;
                maxSum = Math.max(maxSum, currentSum);
            }
        }
        return maxSum;
    }
}