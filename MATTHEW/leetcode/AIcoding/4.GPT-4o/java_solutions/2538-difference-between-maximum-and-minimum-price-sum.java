class Solution {
    public int maximumDifference(int[] nums) {
        int maxSum = 0, minSum = 0;
        Arrays.sort(nums);
        for (int i = 0; i < nums.length; i++) {
            maxSum += nums[nums.length - 1 - i];
            minSum += nums[i];
        }
        return maxSum - minSum;
    }
}