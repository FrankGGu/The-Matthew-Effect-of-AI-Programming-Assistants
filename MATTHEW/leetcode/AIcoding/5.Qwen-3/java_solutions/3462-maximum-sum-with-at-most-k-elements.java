public class Solution {

import java.util.Arrays;

public class Solution {
    public long maximumSum(long[] nums, int k) {
        Arrays.sort(nums);
        long sum = 0;
        for (int i = 0; i < k; i++) {
            sum += nums[nums.length - 1 - i];
        }
        return sum;
    }
}
}