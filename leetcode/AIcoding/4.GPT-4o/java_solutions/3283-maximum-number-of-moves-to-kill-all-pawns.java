class Solution {
    public int maxMoves(String[] board) {
        int n = board.length, m = board[0].length();
        int[][] dp = new int[n + 1][m + 1];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (board[i].charAt(j) == 'P') {
                    dp[i + 1][j + 1] = Math.max(dp[i][j], Math.max(dp[i][j + 1], dp[i + 1][j])) + 1;
                } else {
                    dp[i + 1][j + 1] = Math.max(dp[i][j], Math.max(dp[i][j + 1], dp[i + 1][j]));
                }
            }
        }

        return dp[n][m];
    }
}