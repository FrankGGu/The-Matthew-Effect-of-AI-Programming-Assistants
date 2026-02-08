class Solution {
    private static final int MOD = 1000000007;
    private static final int[][] MOVES = {
            {4, 6},
            {6, 8},
            {7, 9},
            {4, 8},
            {0, 3, 9},
            {},
            {0, 1, 7},
            {2, 6},
            {1, 3},
            {2, 4}
    };

    public int knightDialer(int n) {
        int[][] dp = new int[n + 1][10];
        for (int i = 0; i < 10; i++) {
            dp[1][i] = 1;
        }

        for (int i = 2; i <= n; i++) {
            for (int j = 0; j < 10; j++) {
                for (int move : MOVES[j]) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][move]) % MOD;
                }
            }
        }

        int total = 0;
        for (int i = 0; i < 10; i++) {
            total = (total + dp[n][i]) % MOD;
        }

        return total;
    }
}