class Solution {
    public int[] getMaximumXor(int[] nums, int maximumBit) {
        int n = nums.length;
        int[] result = new int[n];
        int xorTotal = 0;
        int maxK = (1 << maximumBit) - 1;

        for (int i = 0; i < n; i++) {
            xorTotal ^= nums[i];
            result[n - 1 - i] = xorTotal ^ maxK;
        }

        return result;
    }
}