class Solution {
    public int maxValueAfterReverse(int[] nums) {
        int total = 0;
        int n = nums.length;
        for (int i = 0; i < n - 1; i++) {
            total += Math.abs(nums[i] - nums[i + 1]);
        }

        int min1 = Integer.MAX_VALUE;
        int max1 = Integer.MIN_VALUE;
        for (int i = 0; i < n - 1; i++) {
            min1 = Math.min(min1, Math.max(nums[i], nums[i + 1]));
            max1 = Math.max(max1, Math.min(nums[i], nums[i + 1]));
        }
        int diff = Math.max(0, (max1 - min1) * 2);

        int max2 = Integer.MIN_VALUE;
        int min2 = Integer.MAX_VALUE;
        for (int i = 1; i < n - 1; i++) {
            int original = Math.abs(nums[i] - nums[i + 1]) + Math.abs(nums[0] - nums[i - 1]);
            int reversed = Math.abs(nums[0] - nums[i + 1]) + Math.abs(nums[i] - nums[i - 1]);
            max2 = Math.max(max2, reversed - original);
        }

        for (int i = 0; i < n - 2; i++) {
            int original = Math.abs(nums[i] - nums[i + 1]) + Math.abs(nums[n - 1] - nums[i + 2]);
            int reversed = Math.abs(nums[n - 1] - nums[i + 1]) + Math.abs(nums[i] - nums[i + 2]);
            min2 = Math.min(min2, reversed - original);
        }

        return total + Math.max(diff, Math.max(max2, -min2));
    }
}