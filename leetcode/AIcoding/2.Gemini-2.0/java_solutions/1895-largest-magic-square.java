class Solution {
    public int largestMagicSquare(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] rowSum = new int[m + 1][n + 1];
        int[][] colSum = new int[m + 1][n + 1];

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                rowSum[i][j] = rowSum[i][j - 1] + grid[i - 1][j - 1];
                colSum[i][j] = colSum[i - 1][j] + grid[i - 1][j - 1];
            }
        }

        for (int k = Math.min(m, n); k >= 1; k--) {
            for (int i = 0; i <= m - k; i++) {
                for (int j = 0; j <= n - k; j++) {
                    if (isMagicSquare(grid, rowSum, colSum, i, j, k)) {
                        return k;
                    }
                }
            }
        }

        return 1;
    }

    private boolean isMagicSquare(int[][] grid, int[][] rowSum, int[][] colSum, int rowStart, int colStart, int k) {
        int magicSum = rowSum[rowStart + 1][colStart + k] - rowSum[rowStart + 1][colStart];

        for (int i = rowStart + 1; i < rowStart + k + 1; i++) {
            if (rowSum[i][colStart + k] - rowSum[i][colStart] != magicSum) {
                return false;
            }
        }

        for (int j = colStart + 1; j < colStart + k + 1; j++) {
            if (colSum[rowStart + k][j] - colSum[rowStart][j] != magicSum) {
                return false;
            }
        }

        int diagonalSum1 = 0;
        for (int i = 0; i < k; i++) {
            diagonalSum1 += grid[rowStart + i][colStart + i];
        }
        if (diagonalSum1 != magicSum) {
            return false;
        }

        int diagonalSum2 = 0;
        for (int i = 0; i < k; i++) {
            diagonalSum2 += grid[rowStart + i][colStart + k - 1 - i];
        }
        if (diagonalSum2 != magicSum) {
            return false;
        }

        return true;
    }
}