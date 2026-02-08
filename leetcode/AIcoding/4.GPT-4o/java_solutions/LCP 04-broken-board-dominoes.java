class Solution {
    public int dominoes(String board) {
        int n = board.length();
        int[] dp = new int[n + 1];
        dp[0] = 1; // base case: empty board

        for (int i = 1; i <= n; i++) {
            if (board.charAt(i - 1) == '1') {
                dp[i] = dp[i - 1]; // can only continue from previous
            } else {
                dp[i] = dp[i - 1] + (i >= 2 ? dp[i - 2] : 1); // add ways from previous and two before
            }
        }

        return dp[n];
    }
}