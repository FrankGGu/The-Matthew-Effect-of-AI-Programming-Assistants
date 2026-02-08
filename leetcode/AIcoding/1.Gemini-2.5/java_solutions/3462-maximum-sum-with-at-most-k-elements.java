class Solution {
    public int maxSum(int[] nums, int k) {
        int maxVal = 0;
        for (int num : nums) {
            if (num > maxVal) {
                maxVal = num;
            }
        }

        long totalSum = (long)k * maxVal + (long)k * (k - 1) / 2;

        return (int)totalSum;
    }
}