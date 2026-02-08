class Solution {
    private int[][] matrix;
    private int[][] memo;
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

        int maxPath = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                maxPath = Math.max(maxPath, dfs(i, j));
            }
        }

        return maxPath;
    }

    private int dfs(int r, int c) {
        if (memo[r][c] != 0) {
            return memo[r][c];
        }

        int currentMaxPath = 1; 

        for (int[] dir : directions) {
            int nr = r + dir[0];
            int nc = c + dir[1];

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && matrix[nr][nc] > matrix[r][c]) {
                currentMaxPath = Math.max(currentMaxPath, 1 + dfs(nr, nc));
            }
        }

        memo[r][c] = currentMaxPath;
        return currentMaxPath;
    }
}