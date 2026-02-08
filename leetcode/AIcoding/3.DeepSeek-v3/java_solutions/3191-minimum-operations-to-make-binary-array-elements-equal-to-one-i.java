class Solution {
    public int minOperations(int[] nums) {
        int operations = 0;
        for (int i = 0; i < nums.length - 1; i++) {
            if (nums[i] == 1) {
                continue;
            }
            operations++;
            nums[i] ^= 1;
            nums[i + 1] ^= 1;
        }
        if (nums[nums.length - 1] == 0) {
            return -1;
        }
        return operations;
    }
}