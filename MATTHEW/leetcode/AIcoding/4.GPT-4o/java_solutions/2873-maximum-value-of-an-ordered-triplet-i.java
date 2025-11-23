class Solution {
    public int maximumTripletValue(int[] nums) {
        int maxValue = 0;
        int n = nums.length;

        for (int j = 1; j < n - 1; j++) {
            int maxLeft = Integer.MIN_VALUE;
            for (int i = 0; i < j; i++) {
                maxLeft = Math.max(maxLeft, nums[i]);
            }
            int maxRight = Integer.MIN_VALUE;
            for (int k = j + 1; k < n; k++) {
                maxRight = Math.max(maxRight, nums[k]);
            }
            maxValue = Math.max(maxValue, maxLeft + nums[j] - maxRight);
        }

        return maxValue;
    }
}