class Solution {
    public int countWinningSequences(int[] nums) {
        int n = nums.length;
        int[][] dp = new int[n + 1][n + 1];
        int mod = 1000000007;

        for (int i = 0; i <= n; i++) {
            dp[i][0] = 1; // base case
        }

        for (int i = 1; i <= n; i++) {
            for (int j = 1; j <= i; j++) {
                dp[i][j] = (dp[i - 1][j - 1] + dp[i - 1][j]) % mod;
            }
        }

        int totalWinningSequences = 0;
        for (int j = 1; j <= n; j++) {
            totalWinningSequences = (totalWinningSequences + dp[n][j]) % mod;
        }

        return totalWinningSequences;
    }
}