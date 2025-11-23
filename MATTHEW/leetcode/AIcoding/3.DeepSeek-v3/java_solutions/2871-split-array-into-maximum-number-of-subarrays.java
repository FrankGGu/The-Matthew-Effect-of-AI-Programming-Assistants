class Solution {
    public int maxSubarrays(int[] nums) {
        int minAnd = nums[0];
        for (int num : nums) {
            minAnd &= num;
        }
        if (minAnd != 0) {
            return 1;
        }
        int res = 0;
        int currentAnd = (1 << 30) - 1;
        for (int num : nums) {
            currentAnd &= num;
            if (currentAnd == 0) {
                res++;
                currentAnd = (1 << 30) - 1;
            }
        }
        return res;
    }
}