public class Solution {
    public int minSwaps(int[] A, int[] B) {
        int n = A.length;
        int[][] dp = new int[n][2];
        for (int[] row : dp) {
            row[0] = row[1] = Integer.MAX_VALUE;
        }
        dp[0][0] = 0;
        dp[0][1] = 1;

        for (int i = 1; i < n; i++) {
            if (A[i] > A[i - 1] && B[i] > B[i - 1]) {
                dp[i][0] = dp[i - 1][0];
                dp[i][1] = dp[i - 1][1] + 1;
            }
            if (A[i] > B[i - 1] && B[i] > A[i - 1]) {
                dp[i][0] = Math.min(dp[i][0], dp[i - 1][1]);
                dp[i][1] = Math.min(dp[i][1], dp[i - 1][0] + 1);
            }
        }

        return Math.min(dp[n - 1][0], dp[n - 1][1]);
    }
}