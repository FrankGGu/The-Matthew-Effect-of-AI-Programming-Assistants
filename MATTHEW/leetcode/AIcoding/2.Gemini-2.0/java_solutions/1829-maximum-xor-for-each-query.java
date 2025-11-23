class Solution {
    public int[] getMaximumXor(int[] nums, int maximumBit) {
        int n = nums.length;
        int[] result = new int[n];
        int maxXor = (1 << maximumBit) - 1;
        int currentXor = 0;
        for (int num : nums) {
            currentXor ^= num;
        }
        for (int i = 0; i < n; i++) {
            result[n - 1 - i] = maxXor ^ currentXor;
            currentXor ^= nums[n - 1 - i];
        }
        return result;
    }
}