class Solution {
    public boolean canSplitArray(int[] nums, int m) {
        if (nums.length < 2) return true;
        int count = 0;
        for (int i = 1; i < nums.length; i++) {
            if (nums[i - 1] + nums[i] >= m) {
                count++;
            }
        }
        return count >= nums.length - 1;
    }
}