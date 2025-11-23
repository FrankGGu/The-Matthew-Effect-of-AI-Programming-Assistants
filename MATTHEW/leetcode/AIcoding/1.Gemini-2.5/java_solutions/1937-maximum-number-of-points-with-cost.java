import java.util.Arrays;

class Solution {
    public long maxPoints(int[][] points) {
        int m = points.length;
        int n = points[0].length;

        long[] dp = new long[n];

        for (int j = 0; j < n; j++) {
            dp[j] = points[0][j];
        }

        long[] leftMax = new long[n];
        long[] rightMax = new long[n];

        for (int i = 1; i < m; i++) {
            // Calculate leftMax[j] = max(dp[k] + k) for k <= j
            leftMax[0] = dp[0] + 0;
            for (int j = 1; j < n; j++) {
                leftMax[j] = Math.max(leftMax[j - 1], dp[j] + j);
            }

            // Calculate rightMax[j] = max(dp[k] - k) for k >= j
            rightMax[n - 1] = dp[n - 1] - (n - 1);
            for (int j = n - 2; j >= 0; j--) {
                rightMax[j] = Math.max(rightMax[j + 1], dp[j] - j);
            }

            long[] newDp = new long[n];
            for (int j = 0; j < n; j++) {
                newDp[j] = points[i][j] + Math.max(leftMax[j] - j, rightMax[j] + j);
            }
            dp = newDp;
        }

        long maxPoints = 0;
        for (long val : dp) {
            maxPoints = Math.max(maxPoints, val);
        }

        return maxPoints;
    }
}