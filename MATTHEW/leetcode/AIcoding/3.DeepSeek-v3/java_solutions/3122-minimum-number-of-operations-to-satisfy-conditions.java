class Solution {
    public int minimumOperations(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dp = new int[n][10];

        for (int j = 0; j < n; j++) {
            int[] count = new int[10];
            for (int i = 0; i < m; i++) {
                count[grid[i][j]]++;
            }
            for (int k = 0; k < 10; k++) {
                dp[j][k] = m - count[k];
            }
        }

        int[][] memo = new int[n][10];
        for (int k = 0; k < 10; k++) {
            memo[0][k] = dp[0][k];
        }

        for (int j = 1; j < n; j++) {
            for (int k = 0; k < 10; k++) {
                int min = Integer.MAX_VALUE;
                for (int prev = 0; prev < 10; prev++) {
                    if (prev != k) {
                        min = Math.min(min, memo[j - 1][prev]);
                    }
                }
                memo[j][k] = min + dp[j][k];
            }
        }

        int result = Integer.MAX_VALUE;
        for (int k = 0; k < 10; k++) {
            result = Math.min(result, memo[n - 1][k]);
        }
        return result;
    }
}