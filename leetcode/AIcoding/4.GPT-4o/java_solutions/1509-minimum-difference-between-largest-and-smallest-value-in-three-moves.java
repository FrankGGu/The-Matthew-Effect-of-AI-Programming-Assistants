import java.util.Arrays;

public class Solution {
    public int minDifference(int[] nums) {
        if (nums.length <= 4) return 0;
        Arrays.sort(nums);
        return Math.min(Math.min(nums[nums.length - 1] - nums[3], nums[nums.length - 4] - nums[0]), 
                        Math.min(nums[nums.length - 2] - nums[2], nums[1] - nums[nums.length - 3]));
    }
}