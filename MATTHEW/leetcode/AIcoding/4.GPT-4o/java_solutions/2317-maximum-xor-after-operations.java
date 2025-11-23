import java.util.Arrays;

public class Solution {
    public int maximumXor(int[] nums) {
        Arrays.sort(nums);
        return nums[nums.length - 1] | (nums.length - 1);
    }
}