class Solution {
    public long maxArrayValue(int[] nums) {
        int n = nums.length;
        if (n == 0) {
            return 0;
        }

        long currentSum = nums[n - 1];
        long maxVal = currentSum;

        for (int i = n - 2; i >= 0; i--) {
            if (nums[i] <= currentSum) {
                currentSum += nums[i];
            } else {
                currentSum = nums[i];
            }
            maxVal = Math.max(maxVal, currentSum);
        }

        return maxVal;
    }
}