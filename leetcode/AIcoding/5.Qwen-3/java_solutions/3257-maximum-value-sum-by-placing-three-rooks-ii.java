public class Solution {

import java.util.*;

public class Solution {
    public long maximumValueSum(int[] nums) {
        Arrays.sort(nums);
        int n = nums.length;
        long[] dp = new long[n];
        for (int i = 0; i < n; i++) {
            dp[i] = nums[i];
            for (int j = 0; j < i; j++) {
                if ((nums[i] & nums[j]) == 0) {
                    dp[i] = Math.max(dp[i], dp[j] + nums[i]);
                }
            }
        }
        long max = 0;
        for (long val : dp) {
            max = Math.max(max, val);
        }
        return max;
    }
}
}