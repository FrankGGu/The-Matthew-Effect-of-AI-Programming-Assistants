public class Solution {
    public int waysToSplitArray(int[] nums) {
        int total = 0;
        for (int num : nums) {
            total += num;
        }

        int leftSum = 0;
        int count = 0;

        for (int i = 0; i < nums.length - 1; i++) {
            leftSum += nums[i];
            int rightSum = total - leftSum;
            if (leftSum > 0 && rightSum > 0) {
                count++;
            }
        }

        return count;
    }
}