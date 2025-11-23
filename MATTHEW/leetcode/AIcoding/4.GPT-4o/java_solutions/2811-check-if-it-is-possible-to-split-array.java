class Solution {
    public boolean canSplitArray(int[] nums, int m) {
        if (nums.length < 2) return true;
        int count = 1;
        for (int i = 1; i < nums.length; i++) {
            if (nums[i - 1] + nums[i] >= m) {
                count++;
            } else {
                if (count < 2) return false;
                count = 1;
            }
        }
        return count >= 2;
    }
}