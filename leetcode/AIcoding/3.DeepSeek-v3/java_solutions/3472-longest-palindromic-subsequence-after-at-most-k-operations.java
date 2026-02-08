class Solution {
    public int longestPalindromeSubseq(String s, int k) {
        int n = s.length();
        int[][] dp = new int[n][n];
        for (int i = n - 1; i >= 0; i--) {
            dp[i][i] = 1;
            for (int j = i + 1; j < n; j++) {
                if (s.charAt(i) == s.charAt(j)) {
                    dp[i][j] = dp[i + 1][j - 1] + 2;
                } else {
                    dp[i][j] = Math.max(dp[i + 1][j], dp[i][j - 1]);
                }
            }
        }

        int[][] memo = new int[n][n];
        for (int[] row : memo) {
            Arrays.fill(row, -1);
        }
        return helper(s, 0, n - 1, k, dp, memo);
    }

    private int helper(String s, int i, int j, int k, int[][] dp, int[][] memo) {
        if (k == 0) {
            return dp[i][j];
        }
        if (i >= j) {
            return j - i + 1;
        }
        if (memo[i][j] != -1) {
            return memo[i][j];
        }
        int res;
        if (s.charAt(i) == s.charAt(j)) {
            res = helper(s, i + 1, j - 1, k, dp, memo) + 2;
        } else {
            res = Math.max(helper(s, i + 1, j, k - 1, dp, memo), helper(s, i, j - 1, k - 1, dp, memo));
        }
        memo[i][j] = res;
        return res;
    }
}