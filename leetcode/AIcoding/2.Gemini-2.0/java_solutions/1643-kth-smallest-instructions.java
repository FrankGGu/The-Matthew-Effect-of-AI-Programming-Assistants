class Solution {
    public String kthSmallestPath(int[] destination, int k) {
        int m = destination[0];
        int n = destination[1];
        int[][] dp = new int[m + n + 1][n + 1];
        for (int i = 0; i <= m + n; i++) {
            for (int j = 0; j <= n; j++) {
                dp[i][j] = -1;
            }
        }

        StringBuilder sb = new StringBuilder();
        int row = 0, col = 0;
        while (row < m || col < n) {
            if (col == n) {
                sb.append('V');
                row++;
            } else if (row == m) {
                sb.append('H');
                col++;
            } else {
                int horizontalPaths = combinations(m + n - row - col - 1, n - col - 1, dp);
                if (k <= horizontalPaths) {
                    sb.append('H');
                    col++;
                } else {
                    sb.append('V');
                    row++;
                    k -= horizontalPaths;
                }
            }
        }
        return sb.toString();
    }

    private int combinations(int n, int k, int[][] dp) {
        if (k < 0 || k > n) {
            return 0;
        }
        if (k == 0 || k == n) {
            return 1;
        }
        if (dp[n][k] != -1) {
            return dp[n][k];
        }
        return dp[n][k] = combinations(n - 1, k - 1, dp) + combinations(n - 1, k, dp);
    }
}