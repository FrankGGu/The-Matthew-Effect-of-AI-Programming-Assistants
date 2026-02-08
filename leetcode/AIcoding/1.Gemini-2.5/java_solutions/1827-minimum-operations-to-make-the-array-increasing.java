class Solution {
    public long minOperations(int[] nums) {
        if (nums.length < 2) {
            return 0;
        }

        long operations = 0;
        for (int i = 1; i < nums.length; i++) {
            if (nums[i] <= nums[i - 1]) {
                long requiredValue = (long) nums[i - 1] + 1;
                operations += (requiredValue - nums[i]);
                nums[i] = (int) requiredValue;
            }
        }
        return operations;
    }
}