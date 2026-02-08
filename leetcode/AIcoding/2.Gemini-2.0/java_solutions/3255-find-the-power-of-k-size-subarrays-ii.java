class Solution {
    public long findMaximumSubarrayValue(int[] nums, int k) {
        int n = nums.length;
        long maxVal = Long.MIN_VALUE;
        long currentVal = 0;

        for (int i = 0; i < n; i++) {
            currentVal = 0;
            for (int j = i; j < Math.min(i + k, n); j++) {
                currentVal += nums[j];
            }
            maxVal = Math.max(maxVal, currentVal * currentVal);

            for (int j = i + k; j < n; j++) {
                currentVal += nums[j];
                maxVal = Math.max(maxVal, currentVal * currentVal);
                currentVal -= nums[j - k +1];
            }
        }

        return maxVal;
    }
}