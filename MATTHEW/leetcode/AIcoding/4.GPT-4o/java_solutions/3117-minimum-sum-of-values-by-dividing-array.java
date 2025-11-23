import java.util.Arrays;

class Solution {
    public int minimumSum(int[] nums) {
        Arrays.sort(nums);
        return nums[0] + nums[1] + nums[2] + nums[3];
    }
}