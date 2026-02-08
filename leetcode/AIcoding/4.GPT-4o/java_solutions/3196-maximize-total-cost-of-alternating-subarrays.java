class Solution {
    public long maximumAlternatingSubarraySum(int[] nums) {
        long maxSum = 0, currentSum = 0;
        boolean isPositive = true;

        for (int num : nums) {
            if (isPositive) {
                currentSum += num;
            } else {
                currentSum -= num;
            }
            maxSum = Math.max(maxSum, currentSum);
            if (currentSum < 0) {
                currentSum = 0;
            }
            isPositive = !isPositive;
        }

        return maxSum;
    }
}