class Solution {
    public int rob(int[] nums) {
        int n = nums.length;
        if (n == 0) return 0;
        if (n == 1) return nums[0];
        if (n == 2) return Math.max(nums[0], nums[1]);

        return Math.max(robHelper(nums, 0, n - 2), robHelper(nums, 1, n - 1));
    }

    private int robHelper(int[] nums, int start, int end) {
        int rob = 0, notRob = 0;
        for (int i = start; i <= end; i++) {
            int prevRob = rob;
            rob = notRob + nums[i];
            notRob = Math.max(prevRob, notRob);
        }
        return Math.max(rob, notRob);
    }
}