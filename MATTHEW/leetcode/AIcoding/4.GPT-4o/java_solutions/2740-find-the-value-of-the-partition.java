import java.util.Arrays;

class Solution {
    public int findValueOfPartition(int[] nums) {
        Arrays.sort(nums);
        int minDifference = Integer.MAX_VALUE;
        for (int i = 1; i < nums.length; i++) {
            minDifference = Math.min(minDifference, nums[i] - nums[i - 1]);
        }
        return minDifference;
    }
}