class Solution {
    public long maximumTripletValue(int[] nums) {
        int n = nums.length;
        long maxVal = 0;
        int[] maxLeft = new int[n];
        int[] maxRight = new int[n];

        maxLeft[0] = nums[0];
        for (int i = 1; i < n; i++) {
            maxLeft[i] = Math.max(maxLeft[i - 1], nums[i]);
        }

        maxRight[n - 1] = nums[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            maxRight[i] = Math.max(maxRight[i + 1], nums[i]);
        }

        for (int j = 1; j < n - 1; j++) {
            long val = (long) (maxLeft[j - 1] - nums[j]) * maxRight[j + 1];
            maxVal = Math.max(maxVal, val);
        }

        return maxVal;
    }
}