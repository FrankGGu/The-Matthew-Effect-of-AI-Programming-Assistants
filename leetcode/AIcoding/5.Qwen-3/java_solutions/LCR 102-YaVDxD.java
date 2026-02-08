public class Solution {

import java.util.*;

public class Solution {
    public int findTargetSumWays(int[] nums, int target) {
        int sum = 0;
        for (int num : nums) {
            sum += num;
        }
        if (Math.abs(target) > sum) return 0;
        int[] dp = new int[sum * 2 + 1];
        dp[sum] = 1;
        for (int num : nums) {
            int[] newDp = new int[sum * 2 + 1];
            for (int i = 0; i < sum * 2 + 1; i++) {
                if (dp[i] > 0) {
                    newDp[i + num] += dp[i];
                    newDp[i - num] += dp[i];
                }
            }
            dp = newDp;
        }
        return dp[sum + target];
    }
}
}