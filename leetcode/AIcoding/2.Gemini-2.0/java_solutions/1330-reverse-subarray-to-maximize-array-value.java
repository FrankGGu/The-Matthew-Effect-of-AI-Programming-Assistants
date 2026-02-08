class Solution {
    public int maxValueAfterReverse(int[] nums) {
        int n = nums.length;
        int sum = 0;
        for (int i = 0; i < n - 1; i++) {
            sum += Math.abs(nums[i] - nums[i + 1]);
        }

        int extra = 0;
        for (int i = 1; i < n - 1; i++) {
            extra = Math.max(extra, Math.abs(nums[0] - nums[i + 1]) - Math.abs(nums[i] - nums[i + 1]));
            extra = Math.max(extra, Math.abs(nums[n - 1] - nums[i - 1]) - Math.abs(nums[i] - nums[i - 1]));
        }

        int minMax = Integer.MIN_VALUE;
        int maxMin = Integer.MAX_VALUE;
        for (int i = 0; i < n - 1; i++) {
            minMax = Math.max(minMax, Math.min(nums[i], nums[i + 1]));
            maxMin = Math.min(maxMin, Math.max(nums[i], nums[i + 1]));
        }
        extra = Math.max(extra, 2 * (minMax - maxMin));

        return sum + extra;
    }
}