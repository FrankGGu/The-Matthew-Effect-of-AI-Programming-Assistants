class Solution {
    public boolean canPartition(int[][] grid) {
        int n = grid.length, m = grid[0].length;
        int totalSum = 0;

        for (int[] row : grid) {
            for (int num : row) {
                totalSum += num;
            }
        }

        if (totalSum % 2 != 0) return false;
        int target = totalSum / 2;

        boolean[][] dp = new boolean[target + 1][1 << (n * m)];
        dp[0][0] = true;

        for (int num = 0; num < n * m; num++) {
            int x = num / m, y = num % m;
            for (int sum = target; sum >= grid[x][y]; sum--) {
                for (int mask = (1 << (n * m)) - 1; mask >= 0; mask--) {
                    if (dp[sum - grid[x][y]][mask]) {
                        dp[sum][mask | (1 << num)] = true;
                    }
                }
            }
        }

        return dp[target][(1 << (n * m)) - 1];
    }
}