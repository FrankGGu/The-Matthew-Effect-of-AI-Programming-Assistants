class Solution {
    private static final int[][] DIRECTIONS = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
    private int rows, cols;
    private int[][] matrix;
    private int[][] memo;

    public int longestIncreasingPath(int[][] matrix) {
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return 0;
        }

        this.matrix = matrix;
        this.rows = matrix.length;
        this.cols = matrix[0].length;
        this.memo = new int[rows][cols];

        int maxPath = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                maxPath = Math.max(maxPath, dfs(i, j));
            }
        }

        return maxPath;
    }

    private int dfs(int row, int col) {
        if (memo[row][col] != 0) {
            return memo[row][col];
        }

        int maxLen = 1;
        for (int[] dir : DIRECTIONS) {
            int newRow = row + dir[0];
            int newCol = col + dir[1];

            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && matrix[newRow][newCol] > matrix[row][col]) {
                maxLen = Math.max(maxLen, 1 + dfs(newRow, newCol));
            }
        }

        memo[row][col] = maxLen;
        return maxLen;
    }
}