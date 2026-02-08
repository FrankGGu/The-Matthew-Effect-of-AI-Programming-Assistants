public class Solution {
    public int findRotateSteps(String ring, String key) {
        int n = ring.length(), m = key.length();
        int[][] dp = new int[m + 1][n];
        for (int[] row : dp) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        for (int j = 0; j < n; j++) {
            dp[0][j] = 0;
        }
        for (int i = 1; i <= m; i++) {
            for (int j = 0; j < n; j++) {
                if (ring.charAt(j) == key.charAt(i - 1)) {
                    for (int k = 0; k < n; k++) {
                        if (dp[i - 1][k] < Integer.MAX_VALUE) {
                            int distance = Math.abs(j - k);
                            dp[i][j] = Math.min(dp[i][j], dp[i - 1][k] + Math.min(distance, n - distance) + 1);
                        }
                    }
                }
            }
        }
        int result = Integer.MAX_VALUE;
        for (int j = 0; j < n; j++) {
            result = Math.min(result, dp[m][j]);
        }
        return result;
    }
}