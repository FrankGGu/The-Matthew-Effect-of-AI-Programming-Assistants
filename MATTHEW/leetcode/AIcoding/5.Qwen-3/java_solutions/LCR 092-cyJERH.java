public class Solution {
    public int minFlipsMonoIncr(String s) {
        int n = s.length();
        int[] dp = new int[n + 1];
        for (int i = 0; i < n; i++) {
            dp[i + 1] = dp[i] + (s.charAt(i) == '1' ? 1 : 0);
        }
        int res = Integer.MAX_VALUE;
        for (int i = 0; i <= n; i++) {
            int left = dp[i];
            int right = dp[n] - dp[i];
            res = Math.min(res, left + (right - (i - left)));
        }
        return res;
    }
}