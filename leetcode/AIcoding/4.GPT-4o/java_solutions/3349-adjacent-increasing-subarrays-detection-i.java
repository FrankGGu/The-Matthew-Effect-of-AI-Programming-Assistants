class Solution {
    public boolean hasAdjacentIncreasingSubarrays(int[] nums) {
        for (int i = 1; i < nums.length; i++) {
            if (nums[i] > nums[i - 1]) {
                return true;
            }
        }
        return false;
    }
}