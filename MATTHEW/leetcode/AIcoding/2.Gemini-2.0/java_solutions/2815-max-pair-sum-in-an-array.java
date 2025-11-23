class Solution {
    public int maxSum(int[] nums) {
        int max = -1;
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                if (maxDigit(nums[i]) == maxDigit(nums[j])) {
                    max = Math.max(max, nums[i] + nums[j]);
                }
            }
        }
        return max;
    }

    private int maxDigit(int n) {
        int maxDigit = 0;
        while (n > 0) {
            maxDigit = Math.max(maxDigit, n % 10);
            n /= 10;
        }
        return maxDigit;
    }
}