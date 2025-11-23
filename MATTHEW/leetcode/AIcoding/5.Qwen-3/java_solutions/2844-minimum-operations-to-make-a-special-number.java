public class Solution {
    public int minimumOperationsToMakeASpecialNumber(String num, int m) {
        int n = num.length();
        int[] dp = new int[n + 1];
        for (int i = 0; i <= n; i++) {
            dp[i] = Integer.MAX_VALUE;
        }
        dp[0] = 0;
        for (int i = 1; i <= n; i++) {
            for (int j = i - 1; j >= 0; j--) {
                String sub = num.substring(j, i);
                if (sub.length() > 1 && sub.charAt(0) == '0') continue;
                int val = Integer.parseInt(sub);
                if (val % m == 0) {
                    if (dp[j] != Integer.MAX_VALUE) {
                        dp[i] = Math.min(dp[i], dp[j] + 1);
                    }
                }
            }
        }
        return dp[n];
    }
}