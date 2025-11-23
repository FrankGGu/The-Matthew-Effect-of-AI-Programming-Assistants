class Solution {
    public int dominantIndex(int[] nums) {
        int max1 = -1;
        int max2 = -1;
        int max1_idx = -1;

        for (int i = 0; i < nums.length; i++) {
            if (nums[i] > max1) {
                max2 = max1;
                max1 = nums[i];
                max1_idx = i;
            } else if (nums[i] > max2) {
                max2 = nums[i];
            }
        }

        if (max1 >= 2 * max2) {
            return max1_idx;
        } else {
            return -1;
        }
    }
}