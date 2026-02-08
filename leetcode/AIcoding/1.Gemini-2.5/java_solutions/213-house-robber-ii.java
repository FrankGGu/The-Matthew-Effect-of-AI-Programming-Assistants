class Solution {
    private int robSimple(int[] nums, int start, int end) {
        int prev2 = 0;
        int prev1 = 0;

        for (int i = start; i <= end; i++) {
            int current = Math.max(prev1, prev2 + nums[i]);
            prev2 = prev1;
            prev1 = current;
        }
        return prev1;
    }

    public int rob(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }
        if (nums.length == 1) {
            return nums[0];
        }

        int max1 = robSimple(nums, 0, nums.length - 2);
        int max2 = robSimple(nums, 1, nums.length - 1);

        return Math.max(max1, max2);
    }
}