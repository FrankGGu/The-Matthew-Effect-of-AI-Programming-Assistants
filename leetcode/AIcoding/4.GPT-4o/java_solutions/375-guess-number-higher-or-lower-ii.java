public class Solution {
    public int getMoneyAmount(int n) {
        int[][] dp = new int[n + 1][n + 1];
        for (int length = 2; length <= n; length++) {
            for (int start = 1; start <= n - length + 1; start++) {
                int end = start + length - 1;
                dp[start][end] = Integer.MAX_VALUE;
                for (int guess = start; guess < end; guess++) {
                    dp[start][end] = Math.min(dp[start][end], guess + Math.max(dp[start][guess - 1], dp[guess + 1][end]));
                }
            }
        }
        return dp[1][n];
    }
}