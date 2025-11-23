import java.util.Arrays;

class Solution {
    public int findTheValueOfThePartition(int[] nums) {
        Arrays.sort(nums);
        int minDiff = Integer.MAX_VALUE;
        for (int i = 1; i < nums.length; i++) {
            minDiff = Math.min(minDiff, nums[i] - nums[i - 1]);
        }
        return minDiff;
    }
}