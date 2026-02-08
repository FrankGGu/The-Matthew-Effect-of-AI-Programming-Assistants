public class Solution {
    public int getMoneyAmount(int n) {
        int[][] dp = new int[n + 1][n + 1];

        for (int len = 2; len <= n; len++) {
            for (int start = 1; start <= n - len + 1; start++) {
                int end = start + len - 1;
                dp[start][end] = Integer.MAX_VALUE;
                for (int i = start; i <= end; i++) {
                    int cost = i + Math.max((i - 1 >= start) ? dp[start][i - 1] : 0, (i + 1 <= end) ? dp[i + 1][end] : 0);
                    dp[start][end] = Math.min(dp[start][end], cost);
                }
            }
        }

        return dp[1][n];
    }
}