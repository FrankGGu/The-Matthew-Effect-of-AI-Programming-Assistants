class Solution {
    public int maximumDifference(int[] nums) {
        int maxDiff = -1;
        int minValue = nums[0];

        for (int i = 1; i < nums.length; i++) {
            if (nums[i] > minValue) {
                maxDiff = Math.max(maxDiff, nums[i] - minValue);
            } else {
                minValue = nums[i];
            }
        }

        return maxDiff;
    }
}