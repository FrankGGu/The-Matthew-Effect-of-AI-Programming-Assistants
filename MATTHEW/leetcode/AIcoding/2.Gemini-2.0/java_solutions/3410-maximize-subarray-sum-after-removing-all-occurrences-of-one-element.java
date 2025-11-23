class Solution {
    public int maximizeSum(int[] nums, int k) {
        int n = nums.length;
        int maxSum = Integer.MIN_VALUE;

        for (int i = 0; i <= n; i++) {
            int currentSum = 0;
            int currentMax = Integer.MIN_VALUE;

            for (int j = 0; j < n; j++) {
                if (i == n || nums[j] != k) {
                    currentSum += nums[j];
                    currentMax = Math.max(currentMax, currentSum);
                    if (currentSum < 0) {
                        currentSum = 0;
                    }
                }
            }

            maxSum = Math.max(maxSum, currentMax);
            if(maxSum < 0 && currentMax == 0) {
                maxSum = Math.max(maxSum, 0);
            }
        }

        return maxSum;
    }
}