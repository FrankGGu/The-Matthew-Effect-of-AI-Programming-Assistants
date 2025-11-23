public class Solution {

import java.util.Arrays;

public class Solution {
    public int maximumSum(int[] nums, int k) {
        Arrays.sort(nums);
        int sum = 0;
        for (int i = nums.length - 1; i >= nums.length - k; i--) {
            sum += nums[i];
        }
        return sum;
    }
}
}