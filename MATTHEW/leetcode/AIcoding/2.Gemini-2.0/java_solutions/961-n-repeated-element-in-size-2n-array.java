class Solution {
    public int repeatedNTimes(int[] nums) {
        int n = nums.length / 2;
        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < Math.min(i + 4, nums.length); j++) {
                if (nums[i] == nums[j]) {
                    return nums[i];
                }
            }
        }
        return -1;
    }
}