import java.util.Arrays;

public class Solution {
    public double findMedian(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        if (n % 2 == 1) {
            return nums[n / 2];
        } else {
            return (nums[n / 2 - 1] + nums[n / 2]) / 2.0;
        }
    }
}