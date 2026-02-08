class Solution {
    public int[] pathsWithMaxScore(List<String> board) {
        int n = board.size();
        long[][] dp = new long[n][n];
        int[][] count = new int[n][n];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dp[i], Long.MIN_VALUE);
        }
        dp[n - 1][n - 1] = 0;
        count[n - 1][n - 1] = 1;

        for (int i = n - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                if (board.charAt(i).charAt(j) == 'X') continue;
                long score = board.charAt(i).charAt(j) == 'E' ? 0 : board.charAt(i).charAt(j) - '0';
                if (i + 1 < n) {
                    update(dp, count, i, j, dp[i + 1][j], count[i + 1][j], score);
                }
                if (j + 1 < n) {
                    update(dp, count, i, j, dp[i][j + 1], count[i][j + 1], score);
                }
                if (i + 1 < n && j + 1 < n) {
                    update(dp, count, i, j, dp[i + 1][j + 1], count[i + 1][j + 1], score);
                }
            }
        }

        if (dp[0][0] < 0) return new int[]{0, 0};
        return new int[]{(int)(dp[0][0] % 1000000007), count[0][0]};
    }

    private void update(long[][] dp, int[][] count, int i, int j, long newScore, int newCount, long score) {
        if (newScore < dp[i][j] + score) {
            dp[i][j] = newScore + score;
            count[i][j] = newCount;
        } else if (newScore == dp[i][j] + score) {
            count[i][j] += newCount;
        }
    }
}