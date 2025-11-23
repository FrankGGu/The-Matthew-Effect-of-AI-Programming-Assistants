class Solution {
    public int miceAndCheese(int[] mice, int[] cheese) {
        int n = mice.length;
        int[] dp = new int[n + 1];
        for (int i = 0; i < n; i++) {
            dp[i + 1] = Math.max(dp[i] + mice[i], dp[i] + cheese[i]);
        }
        return dp[n];
    }
}