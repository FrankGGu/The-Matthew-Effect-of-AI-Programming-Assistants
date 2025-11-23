class Solution {
    private int[][] dp;
    private int[][] dirs = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
    private int m, n;

    public int longestIncreasingPath(int[][] matrix) {
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return 0;
        }

        m = matrix.length;
        n = matrix[0].length;
        dp = new int[m][n];
        int overallMax = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                overallMax = Math.max(overallMax, dfs(matrix, i, j));
            }
        }

        return overallMax;
    }

    private int dfs(int[][] matrix, int r, int c) {
        if (dp[r][c] != 0) {
            return dp[r][c];
        }

        int maxLen = 1; // Minimum path length is 1 (the cell itself)

        for (int[] dir : dirs) {
            int nr = r + dir[0];
            int nc = c + dir[1];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n && matrix[nr][nc] > matrix[r][c]) {
                maxLen = Math.max(maxLen, 1 + dfs(matrix, nr, nc));
            }
        }

        dp[r][c] = maxLen;
        return maxLen;
    }
}