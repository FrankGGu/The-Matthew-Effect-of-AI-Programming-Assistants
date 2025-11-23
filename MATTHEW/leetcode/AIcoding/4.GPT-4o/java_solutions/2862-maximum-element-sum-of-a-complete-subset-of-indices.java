class Solution {
    public int maxElementSum(int[] nums) {
        int n = nums.length;
        int maxSum = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                int currentSum = 0;
                for (int k = i; k <= j; k++) {
                    currentSum += nums[k];
                }
                maxSum = Math.max(maxSum, currentSum);
            }
        }
        return maxSum;
    }
}