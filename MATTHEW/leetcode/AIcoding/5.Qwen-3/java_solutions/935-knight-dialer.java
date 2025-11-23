public class Solution {
    public int knightDialer(int n) {
        int[][] dp = new int[n][10];
        int[][] moves = {
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
        int mod = 1000000007;

        for (int i = 0; i < 10; i++) {
            dp[0][i] = 1;
        }

        for (int i = 1; i < n; i++) {
            for (int j = 0; j < 10; j++) {
                for (int move : moves[j]) {
                    dp[i][j] += dp[i - 1][move];
                    dp[i][j] %= mod;
                }
            }
        }

        int result = 0;
        for (int i = 0; i < 10; i++) {
            result += dp[n - 1][i];
            result %= mod;
        }

        return result;
    }
}