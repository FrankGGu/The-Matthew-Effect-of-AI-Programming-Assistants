class Solution {
    public int longestIncreasingPath(int[][] matrix) {
        if (matrix.length == 0 || matrix[0].length == 0) return 0;
        int m = matrix.length, n = matrix[0].length;
        int[][] dp = new int[m][n];
        int maxPath = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                maxPath = Math.max(maxPath, dfs(matrix, dp, i, j));
            }
        }
        return maxPath;
    }

    private int dfs(int[][] matrix, int[][] dp, int x, int y) {
        if (dp[x][y] != 0) return dp[x][y];
        int maxLength = 1;
        int[] directions = {-1, 0, 1, 0, -1};

        for (int i = 0; i < 4; i++) {
            int newX = x + directions[i];
            int newY = y + directions[i + 1];
            if (newX >= 0 && newX < matrix.length && newY >= 0 && newY < matrix[0].length &&
                matrix[newX][newY] > matrix[x][y]) {
                maxLength = Math.max(maxLength, 1 + dfs(matrix, dp, newX, newY));
            }
        }
        dp[x][y] = maxLength;
        return maxLength;
    }
}