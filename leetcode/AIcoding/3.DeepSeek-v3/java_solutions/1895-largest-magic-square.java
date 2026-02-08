class Solution {
    public int largestMagicSquare(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] rowSum = new int[m][n + 1];
        int[][] colSum = new int[m + 1][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                rowSum[i][j + 1] = rowSum[i][j] + grid[i][j];
                colSum[i + 1][j] = colSum[i][j] + grid[i][j];
            }
        }

        int maxSize = 1;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                for (int size = maxSize + 1; size <= Math.min(m - i, n - j); size++) {
                    if (isMagicSquare(grid, i, j, size, rowSum, colSum)) {
                        maxSize = size;
                    }
                }
            }
        }
        return maxSize;
    }

    private boolean isMagicSquare(int[][] grid, int x, int y, int size, int[][] rowSum, int[][] colSum) {
        int sum = 0;
        for (int i = x; i < x + size; i++) {
            sum += grid[i][y];
        }

        for (int j = y; j < y + size; j++) {
            int row = rowSum[x][j + 1] - rowSum[x][j + 1 - size];
            if (row != sum) return false;
        }

        for (int i = x; i < x + size; i++) {
            int col = colSum[i + 1][y] - colSum[i + 1 - size][y];
            if (col != sum) return false;
        }

        int diag1 = 0, diag2 = 0;
        for (int k = 0; k < size; k++) {
            diag1 += grid[x + k][y + k];
            diag2 += grid[x + k][y + size - 1 - k];
        }
        if (diag1 != sum || diag2 != sum) return false;

        return true;
    }
}