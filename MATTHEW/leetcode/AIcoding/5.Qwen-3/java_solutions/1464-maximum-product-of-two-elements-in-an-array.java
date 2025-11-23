public class Solution {

import java.util.Arrays;

public class Solution {
    public int maxProduct(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        return Math.max(nums[n - 1] * nums[n - 2], nums[0] * nums[1]);
    }
}
}