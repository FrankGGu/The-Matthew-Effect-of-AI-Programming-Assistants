class Solution {
    public int maxAscendingSum(int[] nums) {
        int max_sum = nums[0];
        int current_sum = nums[0];
        for (int i = 1; i < nums.length; i++) {
            if (nums[i] > nums[i - 1]) {
                current_sum += nums[i];
            } else {
                current_sum = nums[i];
            }
            max_sum = Math.max(max_sum, current_sum);
        }
        return max_sum;
    }
}