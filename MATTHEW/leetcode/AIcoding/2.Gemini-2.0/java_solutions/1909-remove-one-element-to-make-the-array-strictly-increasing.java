class Solution {
    public boolean canBeIncreasing(int[] nums) {
        int count = 0;
        int prev = nums[0];
        for (int i = 1; i < nums.length; i++) {
            if (nums[i] <= prev) {
                count++;
                if (i > 1 && nums[i] <= nums[i - 2]) {
                    prev = nums[i - 1];
                }
            } else {
                prev = nums[i];
            }
        }
        return count <= 1;
    }
}