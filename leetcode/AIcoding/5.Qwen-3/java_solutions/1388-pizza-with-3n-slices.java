public class Solution {

import java.util.Arrays;

public class Solution {
    public int maxSize(int[] slices) {
        int n = slices.length;
        int[][] dp = new int[n][n];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dp[i], -1);
        }
        return Math.max(helper(slices, 0, n - 2, dp), helper(slices, 1, n - 1, dp));
    }

    private int helper(int[] slices, int start, int end, int[][] dp) {
        if (start > end) {
            return 0;
        }
        if (dp[start][end] != -1) {
            return dp[start][end];
        }
        int max = 0;
        for (int i = start; i <= end; i++) {
            max = Math.max(max, slices[i] + helper(slices, start, i - 2, dp) + helper(slices, i + 2, end, dp));
        }
        dp[start][end] = max;
        return max;
    }
}
}