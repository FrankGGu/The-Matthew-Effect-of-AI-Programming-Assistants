class Solution {
    public int minOperations(int[][] grid) {
        int n = grid.length;
        if (n <= 1) {
            return 0;
        }
        int m = grid[0].length;

        int[] dp = new int[n];
        int maxLen = 0;

        for (int i = 0; i < n; i++) {
            dp[i] = 1;
            for (int j = 0; j < i; j++) {
                boolean canFollow = true;
                for (int k = 0; k < m; k++) {
                    if (grid[j][k] >= grid[i][k]) {
                        canFollow = false;
                        break;
                    }
                }
                if (canFollow) {
                    dp[i] = Math.max(dp[i], 1 + dp[j]);
                }
            }
            maxLen = Math.max(maxLen, dp[i]);
        }

        return n - maxLen;
    }
}