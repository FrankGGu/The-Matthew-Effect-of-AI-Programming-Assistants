class Solution {
    public int maxValueAfterReverse(int[] nums) {
        int n = nums.length;
        int max = 0;
        int total = 0;
        int minLeft = Integer.MAX_VALUE;
        int maxLeft = Integer.MIN_VALUE;
        int minRight = Integer.MAX_VALUE;
        int maxRight = Integer.MIN_VALUE;

        for (int i = 0; i < n - 1; i++) {
            total += Math.abs(nums[i] - nums[i + 1]);
            minLeft = Math.min(minLeft, Math.max(nums[i], nums[i + 1]));
            maxLeft = Math.max(maxLeft, Math.min(nums[i], nums[i + 1]));
        }

        for (int i = 0; i < n; i++) {
            if (i > 0) {
                max = Math.max(max, Math.abs(nums[i] - nums[0]));
            }
            if (i < n - 1) {
                max = Math.max(max, Math.abs(nums[n - 1] - nums[i]));
            }
        }

        return total + Math.max(max, Math.max(maxLeft - minLeft, maxRight - minRight));
    }
}