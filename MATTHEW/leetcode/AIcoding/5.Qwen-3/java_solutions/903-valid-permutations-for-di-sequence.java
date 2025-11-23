public class Solution {
    public int numPermsDISequence(String S) {
        int n = S.length();
        int[][] dp = new int[n + 1][n + 1];
        for (int i = 0; i <= n; i++) {
            dp[0][i] = 1;
        }
        for (int i = 1; i <= n; i++) {
            for (int j = 0; j <= i; j++) {
                if (S.charAt(i - 1) == 'D') {
                    for (int k = 0; k < j; k++) {
                        dp[i][j] += dp[i - 1][k];
                    }
                } else {
                    for (int k = j; k < i; k++) {
                        dp[i][j] += dp[i - 1][k];
                    }
                }
            }
        }
        int result = 0;
        for (int i = 0; i <= n; i++) {
            result += dp[n][i];
        }
        return result;
    }
}