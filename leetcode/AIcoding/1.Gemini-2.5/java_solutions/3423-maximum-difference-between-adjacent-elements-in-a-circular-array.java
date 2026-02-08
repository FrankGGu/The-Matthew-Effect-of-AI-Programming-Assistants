class Solution {
    public int maxDifference(int[] nums) {
        if (nums.length == 0) {
            return 0;
        }

        int n = nums.length;
        int maxDiff = 0;

        for (int i = 0; i < n - 1; i++) {
            maxDiff = Math.max(maxDiff, Math.abs(nums[i] - nums[i+1]));
        }

        maxDiff = Math.max(maxDiff, Math.abs(nums[n-1] - nums[0]));

        return maxDiff;
    }
}