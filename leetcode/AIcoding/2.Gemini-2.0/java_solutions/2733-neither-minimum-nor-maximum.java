class Solution {
    public int findNonMinOrMax(int[] nums) {
        if (nums.length <= 2) {
            return -1;
        }
        int minVal = Math.min(nums[0], Math.min(nums[1], nums[2]));
        int maxVal = Math.max(nums[0], Math.max(nums[1], nums[2]));
        for (int num : new int[]{nums[0], nums[1], nums[2]}) {
            if (num != minVal && num != maxVal) {
                return num;
            }
        }
        return -1;
    }
}