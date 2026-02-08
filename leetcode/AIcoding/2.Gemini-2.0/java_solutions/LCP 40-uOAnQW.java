class Solution {
    public int cardGame(int[] cards) {
        int n = cards.length;
        int[] dp = new int[n];
        dp[0] = cards[0];
        dp[1] = Math.max(cards[0], cards[1]);

        for (int i = 2; i < n; i++) {
            dp[i] = Math.max(dp[i - 1], dp[i - 2] + cards[i]);
        }

        return dp[n - 1];
    }
}