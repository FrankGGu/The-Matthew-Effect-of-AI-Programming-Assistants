public class Solution {

import java.util.*;

public class Solution {
    public int largestMagicSquare(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int max = 1;

        int[][] rowSums = new int[m][n];
        int[][] colSums = new int[m][n];

        for (int i = 0; i < m; i++) {
            rowSums[i][0] = grid[i][0];
            for (int j = 1; j < n; j++) {
                rowSums[i][j] = rowSums[i][j - 1] + grid[i][j];
            }
        }

        for (int j = 0; j < n; j++) {
            colSums[0][j] = grid[0][j];
            for (int i = 1; i < m; i++) {
                colSums[i][j] = colSums[i - 1][j] + grid[i][j];
            }
        }

        for (int k = 2; k <= Math.min(m, n); k++) {
            for (int i = 0; i <= m - k; i++) {
                for (int j = 0; j <= n - k; j++) {
                    if (isMagic(grid, rowSums, colSums, i, j, k)) {
                        max = Math.max(max, k);
                    }
                }
            }
        }

        return max;
    }

    private boolean isMagic(int[][] grid, int[][] rowSums, int[][] colSums, int x, int y, int size) {
        int target = rowSums[x][y + size - 1];
        for (int i = x + 1; i < x + size; i++) {
            if (rowSums[i][y + size - 1] - rowSums[i][y - 1] != target) {
                return false;
            }
        }

        for (int j = y; j < y + size; j++) {
            if (colSums[x + size - 1][j] - (x == 0 ? 0 : colSums[x - 1][j]) != target) {
                return false;
            }
        }

        int diag1 = 0;
        for (int i = 0; i < size; i++) {
            diag1 += grid[x + i][y + i];
        }
        if (diag1 != target) return false;

        int diag2 = 0;
        for (int i = 0; i < size; i++) {
            diag2 += grid[x + i][y + size - 1 - i];
        }
        if (diag2 != target) return false;

        return true;
    }
}
}