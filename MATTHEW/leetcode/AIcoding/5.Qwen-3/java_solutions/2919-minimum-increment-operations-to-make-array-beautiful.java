public class Solution {

import java.util.*;

public class Solution {
    public int minIncrementOperationsToMakeArrayBeautiful(int[] nums) {
        int n = nums.length;
        if (n < 3) return 0;

        int[] dp = new int[n];
        Arrays.fill(dp, 0);

        for (int i = 2; i < n; i++) {
            dp[i] = Math.min(dp[i - 1], Math.min(dp[i - 2], dp[i - 3])) + nums[i];
        }

        return Math.min(dp[n - 1], Math.min(dp[n - 2], dp[n - 3]));
    }
}
}