class Solution {
    public long maxArrayValue(int[] nums) {
        long max = nums[nums.length - 1];
        long current = max;

        for (int i = nums.length - 2; i >= 0; i--) {
            if (nums[i] <= current) {
                current += nums[i];
            } else {
                current = nums[i];
            }
            max = Math.max(max, current);
        }

        return max;
    }
}