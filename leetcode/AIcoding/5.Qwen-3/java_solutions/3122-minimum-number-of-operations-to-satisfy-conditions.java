public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums) {
        int n = nums.length;
        int[] dp = new int[n];
        Arrays.fill(dp, 1);

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < i; j++) {
                if (nums[j] < nums[i] && dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                }
            }
        }

        int maxLen = 0;
        for (int val : dp) {
            maxLen = Math.max(maxLen, val);
        }

        return n - maxLen;
    }
}
}