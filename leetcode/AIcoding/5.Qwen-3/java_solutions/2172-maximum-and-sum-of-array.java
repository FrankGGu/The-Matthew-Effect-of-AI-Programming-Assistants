public class Solution {

import java.util.*;

public class Solution {
    public int maxAndSum(int[] nums) {
        int n = nums.length;
        int[][] dp = new int[n][1 << n];
        Arrays.fill(dp[0], -1);
        dp[0][0] = 0;

        for (int i = 0; i < n; i++) {
            for (int mask = 0; mask < (1 << n); mask++) {
                if (dp[i][mask] == -1) continue;
                for (int j = 0; j < n; j++) {
                    if ((mask & (1 << j)) == 0) {
                        int newMask = mask | (1 << j);
                        int val = dp[i][mask] + (nums[i] & nums[j]);
                        if (dp[i + 1][newMask] < val) {
                            dp[i + 1][newMask] = val;
                        }
                    }
                }
            }
        }

        int max = 0;
        for (int mask = 0; mask < (1 << n); mask++) {
            max = Math.max(max, dp[n][mask]);
        }
        return max;
    }
}
}