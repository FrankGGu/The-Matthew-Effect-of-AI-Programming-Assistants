import java.util.Arrays;

class Solution {
    public int maximizeMinimum(int[] nums, int k) {
        Arrays.sort(nums);
        int n = nums.length;
        if (k >= n) {
            return nums[n - 1];
        }
        return nums[k];
    }
}