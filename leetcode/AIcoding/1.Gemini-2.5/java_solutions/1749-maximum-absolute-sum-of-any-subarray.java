class Solution {
    public int maxAbsoluteSum(int[] nums) {
        int maxSoFar = nums[0];
        int currentMax = nums[0];

        int minSoFar = nums[0];
        int currentMin = nums[0];

        for (int i = 1; i < nums.length; i++) {
            currentMax = Math.max(nums[i], currentMax + nums[i]);
            maxSoFar = Math.max(maxSoFar, currentMax);

            currentMin = Math.min(nums[i], currentMin + nums[i]);
            minSoFar = Math.min(minSoFar, currentMin);
        }

        return Math.max(maxSoFar, Math.abs(minSoFar));
    }
}