import java.util.*;

public class Solution {
    public int maxScore(int[] nums) {
        int n = nums.length;
        long[] dp = new long[n + 1];
        Arrays.fill(dp, Long.MIN_VALUE);
        dp[0] = 0;

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j >= 1; j--) {
                if (dp[j - 1] != Long.MIN_VALUE) {
                    dp[j] = Math.max(dp[j], dp[j - 1] + nums[i]);
                }
            }
        }

        return (int) dp[n];
    }
}