public class Solution {
    public int numberOfWays(int startPos, int endPos, int k) {
        int[] dp = new int[k + 1];
        dp[0] = 1;
        for (int step = 1; step <= k; step++) {
            dp[step] = 0;
            if (step - 1 >= 0) dp[step] += dp[step - 1];
            if (step - 1 >= 0) dp[step] += dp[step - 1];
        }
        return Math.abs(startPos - endPos) > k ? 0 : dp[k];
    }
}