public class Solution {

class Solution {
    public int minFlipsMonoIncr(String s) {
        int n = s.length();
        int[] dp = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            if (s.charAt(i - 1) == '1') {
                dp[i] = dp[i - 1];
            } else {
                dp[i] = Math.min(dp[i - 1] + 1, dp[i - 1]);
            }
        }
        return dp[n];
    }
}
}