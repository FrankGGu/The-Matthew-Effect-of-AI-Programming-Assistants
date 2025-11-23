class Solution {
    public long maxPoints(int[][] points) {
        int m = points.length, n = points[0].length;
        long[] dp = new long[n];
        for (int i = 0; i < m; i++) {
            long[] newDp = new long[n];
            for (int j = 0; j < n; j++) {
                newDp[j] = Math.max(newDp[j], dp[j] + points[i][j]);
            }
            for (int j = 0, max = dp[0]; j < n; j++) {
                if (j > 0) max = Math.max(max, dp[j - 1] - j);
                newDp[j] = Math.max(newDp[j], max + j + points[i][j]);
            }
            for (int j = n - 1, max = dp[n - 1]; j >= 0; j--) {
                if (j < n - 1) max = Math.max(max, dp[j + 1] + j);
                newDp[j] = Math.max(newDp[j], max - j + points[i][j]);
            }
            dp = newDp;
        }
        long maxPoints = 0;
        for (long point : dp) {
            maxPoints = Math.max(maxPoints, point);
        }
        return maxPoints;
    }
}