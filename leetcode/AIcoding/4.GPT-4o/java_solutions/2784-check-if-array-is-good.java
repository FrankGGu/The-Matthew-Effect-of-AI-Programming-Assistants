class Solution {
    public boolean isGood(int[] nums) {
        int n = nums.length;
        Arrays.sort(nums);
        return nums[n - 1] == n - 1 && nums[n - 2] == n - 2;
    }
}