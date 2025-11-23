class Solution {
    public int rob(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }
        if (nums.length == 1) {
            return nums[0];
        }

        int n = nums.length;

        // Case 1: Robbing houses from index 0 to n-2 (excluding the last house)
        int result1 = robLinear(nums, 0, n - 2);

        // Case 2: Robbing houses from index 1 to n-1 (excluding the first house)
        int result2 = robLinear(nums, 1, n - 1);

        return Math.max(result1, result2);
    }

    private int robLinear(int[] nums, int start, int end) {
        int prev2 = 0; // Represents max money up to i-2
        int prev1 = 0; // Represents max money up to i-1

        for (int i = start; i <= end; i++) {
            int currentRob = nums[i];
            int currentMax = Math.max(prev1, prev2 + currentRob);
            prev2 = prev1;
            prev1 = currentMax;
        }
        return prev1;
    }
}