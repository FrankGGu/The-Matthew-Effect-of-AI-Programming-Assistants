class Solution {
    public int minSum(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int sum = 0;
        for (int i = 0; i < n / 2; i++) {
            sum += nums[i] * nums[n - 1 - i];
        }
        return sum;
    }
}