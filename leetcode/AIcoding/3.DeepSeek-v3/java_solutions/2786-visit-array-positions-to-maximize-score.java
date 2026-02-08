class Solution {
    public long maxScore(int[] nums, int x) {
        long even = nums[0] - (nums[0] % 2 == 0 ? 0 : x);
        long odd = nums[0] - (nums[0] % 2 != 0 ? 0 : x);

        for (int i = 1; i < nums.length; i++) {
            if (nums[i] % 2 == 0) {
                even = Math.max(even + nums[i], odd + nums[i] - x);
            } else {
                odd = Math.max(odd + nums[i], even + nums[i] - x);
            }
        }

        return Math.max(even, odd);
    }
}