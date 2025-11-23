class Solution {
    public int waysToSplitArray(int[] nums) {
        int n = nums.length;
        long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        long currentSum = 0;
        int count = 0;
        for (int i = 0; i < n - 1; i++) {
            currentSum += nums[i];
            if (currentSum >= totalSum - currentSum) {
                count++;
            }
        }

        return count;
    }
}