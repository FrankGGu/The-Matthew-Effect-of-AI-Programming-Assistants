public class Solution {

import java.util.Arrays;

public class Solution {
    public int getPartitionerValue(int[] nums) {
        Arrays.sort(nums);
        int minDiff = Integer.MAX_VALUE;
        for (int i = 1; i < nums.length; i++) {
            minDiff = Math.min(minDiff, nums[i] - nums[i - 1]);
        }
        return minDiff;
    }
}
}