class Solution {
    private static final int[][] DIRECTIONS = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    public int longestIncreasingPath(int[][] matrix) {
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return 0;
        }

        int rows = matrix.length;
        int cols = matrix[0].length;
        int[][] dp = new int[rows][cols];
        int maxPath = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                maxPath = Math.max(maxPath, dfs(matrix, i, j, dp));
            }
        }

        return maxPath;
    }

    private int dfs(int[][] matrix, int row, int col, int[][] dp) {
        if (dp[row][col] != 0) {
            return dp[row][col];
        }

        int rows = matrix.length;
        int cols = matrix[0].length;
        int maxPath = 1;

        for (int[] dir : DIRECTIONS) {
            int newRow = row + dir[0];
            int newCol = col + dir[1];

            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && matrix[newRow][newCol] > matrix[row][col]) {
                maxPath = Math.max(maxPath, 1 + dfs(matrix, newRow, newCol, dp));
            }
        }

        dp[row][col] = maxPath;
        return maxPath;
    }
}