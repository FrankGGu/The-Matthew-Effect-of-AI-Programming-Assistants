class Solution {
    public int beautifulSplits(int[] nums) {
        int n = nums.length;
        long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        long leftSum = 0;
        int beautifulCount = 0;

        for (int i = 0; i < n - 1; i++) {
            leftSum += nums[i];
            long rightSum = totalSum - leftSum;
            if (leftSum >= rightSum) {
                beautifulCount++;
            }
        }

        return beautifulCount;
    }
}