public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums) {
        int n = nums.length;
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;
        for (int i = 1; i <= n; i++) {
            int xor = 0;
            for (int j = i - 1; j >= 0; j--) {
                xor ^= nums[j];
                if (xor == 0) {
                    dp[i] = Math.min(dp[i], dp[j] + 1);
                }
            }
        }
        return dp[n] == Integer.MAX_VALUE ? -1 : dp[n];
    }
}
}