import java.util.Arrays;

class Solution {
    public int minNumber(String target, String[] words) {
        int n = target.length();
        int[] dp = new int[n + 1];
        Arrays.fill(dp, n + 1);
        dp[0] = 0;

        for (int i = 1; i <= n; i++) {
            dp[i] = dp[i - 1] + 1;
            for (String word : words) {
                int len = word.length();
                if (len <= i) {
                    String sub = target.substring(i - len, i);
                    if (sub.equals(word)) {
                        dp[i] = Math.min(dp[i], dp[i - len]);
                    }
                }
            }
        }

        return dp[n];
    }
}