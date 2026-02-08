class Solution {
    public long maximizeSum(int[] nums, int k) {
        Arrays.sort(nums);
        long sum = 0;
        for (int i = 0; i < k; i++) {
            sum += nums[nums.length - 1] + i;
        }
        return sum;
    }
}