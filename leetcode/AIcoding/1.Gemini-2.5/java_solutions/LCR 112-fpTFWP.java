class Solution {
    private int[][] memo;
    private int[][] matrix;
    private int rows;
    private int cols;
    private int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    public int longestIncreasingPath(int[][] matrix) {
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return 0;
        }

        this.matrix = matrix;
        this.rows = matrix.length;
        this.cols = matrix[0].length;
        this.memo = new int[rows][cols];

        int overallMax = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                overallMax = Math.max(overallMax, dfs(i, j, Integer.MIN_VALUE));
            }
        }
        return overallMax;
    }

    private int dfs(int r, int c, int prevVal) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || matrix[r][c] <= prevVal) {
            return 0;
        }

        if (memo[r][c] != 0) {
            return memo[r][c];
        }

        int maxLen = 1;
        for (int[] dir : directions) {
            int nr = r + dir[0];
            int nc = c + dir[1];
            maxLen = Math.max(maxLen, 1 + dfs(nr, nc, matrix[r][c]));
        }

        memo[r][c] = maxLen;
        return maxLen;
    }
}