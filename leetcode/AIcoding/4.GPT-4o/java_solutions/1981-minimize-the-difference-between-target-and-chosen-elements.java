import java.util.Arrays;

public class Solution {
    public int minimizeTheDifference(int[][] mat, int target) {
        int m = mat.length, n = mat[0].length;
        boolean[][] dp = new boolean[m + 1][5001];
        dp[0][0] = true;

        for (int i = 1; i <= m; i++) {
            for (int j = 0; j < n; j++) {
                for (int k = 5000; k >= mat[i - 1][j]; k--) {
                    dp[i][k] |= dp[i - 1][k - mat[i - 1][j]];
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int k = 0; k <= 5000; k++) {
            if (dp[m][k]) {
                result = Math.min(result, Math.abs(target - k));
            }
        }

        return result;
    }
}