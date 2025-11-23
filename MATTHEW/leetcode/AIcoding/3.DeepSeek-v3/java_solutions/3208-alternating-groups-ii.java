class Solution {
    public boolean isAlternating(int[] nums) {
        if (nums.length <= 2) return true;

        for (int i = 1; i < nums.length; i++) {
            if (i % 2 == 1) {
                if (nums[i] <= nums[i-1]) return false;
            } else {
                if (nums[i] >= nums[i-1]) return false;
            }
        }
        return true;
    }
}