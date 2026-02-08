import java.util.Arrays;

public class Solution {
    public int maxSum(int[] nums, int k) {
        Arrays.sort(nums);
        int sum = 0;
        for (int i = nums.length - k; i < nums.length; i++) {
            sum += nums[i];
        }
        return sum;
    }
}