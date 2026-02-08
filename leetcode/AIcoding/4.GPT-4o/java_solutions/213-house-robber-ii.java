class Solution {
    public int rob(int[] nums) {
        if (nums.length == 1) return nums[0];
        return Math.max(robHelper(Arrays.copyOfRange(nums, 0, nums.length - 1)), 
                         robHelper(Arrays.copyOfRange(nums, 1, nums.length)));
    }

    private int robHelper(int[] nums) {
        int prev = 0, curr = 0;
        for (int num : nums) {
            int temp = curr;
            curr = Math.max(prev + num, curr);
            prev = temp;
        }
        return curr;
    }
}