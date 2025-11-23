class Solution {
    public int minimumSum(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        return nums[0] + nums[1] + nums[n - 2] + nums[n - 1];
    }
}