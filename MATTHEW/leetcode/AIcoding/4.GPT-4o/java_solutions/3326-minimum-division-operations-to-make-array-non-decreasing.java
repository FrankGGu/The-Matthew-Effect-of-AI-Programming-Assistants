class Solution {
    public int minOperations(int[] nums) {
        int n = nums.length;
        int operations = 0;
        for (int i = n - 2; i >= 0; i--) {
            if (nums[i] > nums[i + 1]) {
                operations += nums[i] - nums[i + 1];
                nums[i] = nums[i + 1];
            }
        }
        return operations;
    }
}