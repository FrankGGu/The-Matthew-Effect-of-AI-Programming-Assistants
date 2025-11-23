public class Solution {

import java.util.Arrays;

public class Solution {
    public int smallestRangeII(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        int min = Integer.MAX_VALUE;
        int max = Integer.MIN_VALUE;
        for (int num : nums) {
            min = Math.min(min, num);
            max = Math.max(max, num);
        }
        int result = max - min;
        for (int i = 0; i < n - 1; i++) {
            int a = nums[i];
            int b = nums[i + 1];
            int candidate = Math.max(max, a + (nums[n - 1] - nums[0])) - Math.min(min, b - (nums[n - 1] - nums[0]));
            result = Math.min(result, candidate);
        }
        return result;
    }
}
}