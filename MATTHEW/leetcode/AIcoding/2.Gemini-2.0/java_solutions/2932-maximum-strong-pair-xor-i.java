class Solution {
    public int maximumStrongPairXor(int[] nums) {
        int maxXor = 0;
        for (int i = 0; i < nums.length; i++) {
            for (int j = 0; j < nums.length; j++) {
                if (Math.abs(nums[i] - nums[j]) <= Math.min(nums[i], nums[j])) {
                    maxXor = Math.max(maxXor, nums[i] ^ nums[j]);
                }
            }
        }
        return maxXor;
    }
}