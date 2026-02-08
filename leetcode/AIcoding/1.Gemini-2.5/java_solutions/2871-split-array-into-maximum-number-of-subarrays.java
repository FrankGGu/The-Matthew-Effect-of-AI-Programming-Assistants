class Solution {
    public int maxSubarrays(int[] nums) {
        if (nums.length == 0) {
            return 0;
        }

        for (int num : nums) {
            if (num == 0) {
                return 0;
            }
        }

        return nums.length;
    }
}