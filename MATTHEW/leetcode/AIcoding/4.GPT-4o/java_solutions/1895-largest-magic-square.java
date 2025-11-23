class Solution {
    public int largestMagicSquare(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] sum = new int[m + 1][n + 1];
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                sum[i][j] = grid[i - 1][j - 1] + sum[i - 1][j] + sum[i][j - 1] - sum[i - 1][j - 1];
            }
        }

        int maxSize = 1;
        for (int size = 2; size <= Math.min(m, n); size++) {
            for (int i = 0; i <= m - size; i++) {
                for (int j = 0; j <= n - size; j++) {
                    if (isMagicSquare(sum, i, j, size)) {
                        maxSize = size;
                    }
                }
            }
        }

        return maxSize;
    }

    private boolean isMagicSquare(int[][] sum, int x, int y, int size) {
        int target = sum[x + size][y + size] - sum[x][y + size] - sum[x + size][y] + sum[x][y];
        for (int i = 0; i < size; i++) {
            int rowSum = sum[x + i + 1][y + size] - sum[x + i + 1][y] - sum[x][y + size] + sum[x][y];
            int colSum = sum[x + size][y + i + 1] - sum[x][y + i + 1] - sum[x + size][y] + sum[x][y];
            if (rowSum != target || colSum != target) return false;
        }

        int diag1 = 0, diag2 = 0;
        for (int i = 0; i < size; i++) {
            diag1 += sum[x + i + 1][y + i + 1] - sum[x + i][y + i + 1] - sum[x + i + 1][y + i] + sum[x + i][y + i];
            diag2 += sum[x + i + 1][y + size - i] - sum[x + i][y + size - i] - sum[x + i + 1][y + size - i - 1] + sum[x + i][y + size - i - 1];
        }

        return diag1 == target && diag2 == target;
    }
}