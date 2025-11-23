import java.util.HashSet;
import java.util.Set;

class Solution {
    public int[][] differenceOfDistinctValues(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] result = new int[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                Set<Integer> topLeft = new HashSet<>();
                Set<Integer> bottomRight = new HashSet<>();

                int row = i - 1;
                int col = j - 1;
                while (row >= 0 && col >= 0) {
                    topLeft.add(grid[row][col]);
                    row--;
                    col--;
                }

                row = i + 1;
                col = j + 1;
                while (row < m && col < n) {
                    bottomRight.add(grid[row][col]);
                    row++;
                    col++;
                }

                result[i][j] = Math.abs(topLeft.size() - bottomRight.size());
            }
        }

        return result;
    }
}