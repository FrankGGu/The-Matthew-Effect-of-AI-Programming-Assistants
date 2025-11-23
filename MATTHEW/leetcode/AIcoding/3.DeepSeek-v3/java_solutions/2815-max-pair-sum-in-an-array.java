class Solution {
    public int maxSum(int[] nums) {
        int maxSum = -1;
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                if (maxDigit(nums[i]) == maxDigit(nums[j])) {
                    maxSum = Math.max(maxSum, nums[i] + nums[j]);
                }
            }
        }
        return maxSum;
    }

    private int maxDigit(int num) {
        int max = 0;
        while (num > 0) {
            int digit = num % 10;
            max = Math.max(max, digit);
            num /= 10;
        }
        return max;
    }
}