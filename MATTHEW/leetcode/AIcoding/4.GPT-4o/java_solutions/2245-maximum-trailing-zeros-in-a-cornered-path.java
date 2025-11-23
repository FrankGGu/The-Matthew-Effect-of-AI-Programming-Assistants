class Solution {
    public int maxTrailingZeros(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][][] dp = new int[m + 1][n + 1][2];

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                int[] count = countFactors(grid[i - 1][j - 1]);
                dp[i][j][0] = Math.max(dp[i - 1][j][0], dp[i][j - 1][0]) + count[0];
                dp[i][j][1] = Math.max(dp[i - 1][j][1], dp[i][j - 1][1]) + count[1];
            }
        }

        int maxZeros = 0;
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                maxZeros = Math.max(maxZeros, Math.min(dp[i][j][0], dp[i][j][1]));
            }
        }
        return maxZeros;
    }

    private int[] countFactors(int num) {
        int count2 = 0, count5 = 0;
        while (num % 2 == 0 && num > 0) {
            count2++;
            num /= 2;
        }
        while (num % 5 == 0 && num > 0) {
            count5++;
            num /= 5;
        }
        return new int[] {count2, count5};
    }
}