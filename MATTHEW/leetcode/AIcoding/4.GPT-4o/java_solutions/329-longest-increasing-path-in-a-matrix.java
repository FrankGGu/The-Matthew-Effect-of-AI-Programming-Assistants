class Solution {
    public int longestIncreasingPath(int[][] matrix) {
        if (matrix.length == 0 || matrix[0].length == 0) return 0;
        int rows = matrix.length, cols = matrix[0].length;
        int[][] cache = new int[rows][cols];
        int maxPath = 0;

        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                maxPath = Math.max(maxPath, dfs(matrix, r, c, cache));
            }
        }

        return maxPath;
    }

    private int dfs(int[][] matrix, int r, int c, int[][] cache) {
        if (cache[r][c] != 0) return cache[r][c];
        int maxLength = 1;
        int[][] directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

        for (int[] dir : directions) {
            int newRow = r + dir[0], newCol = c + dir[1];
            if (newRow >= 0 && newRow < matrix.length && newCol >= 0 && newCol < matrix[0].length 
                && matrix[newRow][newCol] > matrix[r][c]) {
                maxLength = Math.max(maxLength, 1 + dfs(matrix, newRow, newCol, cache));
            }
        }

        cache[r][c] = maxLength;
        return maxLength;
    }
}