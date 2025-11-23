class Solution {
    public int maximumStrongPairXor(int[] nums) {
        Arrays.sort(nums);
        int maxXor = 0;
        for (int i = 0; i < nums.length; i++) {
            for (int j = i; j < nums.length; j++) {
                if (nums[j] <= 2 * nums[i]) {
                    maxXor = Math.max(maxXor, nums[i] ^ nums[j]);
                } else {
                    break;
                }
            }
        }
        return maxXor;
    }
}