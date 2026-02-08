public class Solution {

import java.util.*;

public class Solution {
    public long maxAlternatingSubarrays(int[] nums) {
        int n = nums.length;
        long[] dp = new long[n];
        long[] prev = new long[n];

        for (int i = 0; i < n; i++) {
            dp[i] = 1;
            prev[i] = 0;
            for (int j = 0; j < i; j++) {
                if ((nums[j] > nums[i] && prev[j] == 0) || (nums[j] < nums[i] && prev[j] == 1)) {
                    if (dp[j] + 1 > dp[i]) {
                        dp[i] = dp[j] + 1;
                        prev[i] = nums[j] > nums[i] ? 0 : 1;
                    }
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