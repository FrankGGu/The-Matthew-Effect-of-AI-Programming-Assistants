import java.util.Arrays;

public class Solution {
    public int maxHeight(int[] A) {
        Arrays.sort(A);
        int n = A.length;
        int[][] dp = new int[n + 1][n + 1];

        for (int i = 0; i <= n; i++) {
            for (int j = 0; j <= n; j++) {
                dp[i][j] = -1;
            }
        }

        return helper(A, n, 0, 0, dp);
    }

    private int helper(int[] A, int n, int prevHeight, int index, int[][] dp) {
        if (index == n) return 0;
        if (dp[prevHeight][index] != -1) return dp[prevHeight][index];

        int maxHeight = helper(A, n, prevHeight, index + 1, dp);
        if (A[index] > prevHeight) {
            maxHeight = Math.max(maxHeight, A[index] + helper(A, n, A[index], index + 1, dp));
        }

        dp[prevHeight][index] = maxHeight;
        return maxHeight;
    }
}