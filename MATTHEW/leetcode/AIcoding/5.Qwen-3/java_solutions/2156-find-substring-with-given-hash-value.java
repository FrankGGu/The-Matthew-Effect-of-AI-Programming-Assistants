public class Solution {
    public int[] leftRightDifference(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        int leftSum = 0;
        int totalSum = 0;

        for (int num : nums) {
            totalSum += num;
        }

        for (int i = 0; i < n; i++) {
            int rightSum = totalSum - leftSum - nums[i];
            result[i] = Math.abs(leftSum - rightSum);
            leftSum += nums[i];
        }

        return result;
    }
}