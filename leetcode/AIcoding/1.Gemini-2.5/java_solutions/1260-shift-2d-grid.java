import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> shiftGrid(int[][] grid, int k) {
        int m = grid.length;
        if (m == 0) {
            return new ArrayList<>();
        }
        int n = grid[0].length;
        if (n == 0) {
            List<List<Integer>> result = new ArrayList<>();
            for (int i = 0; i < m; i++) {
                result.add(new ArrayList<>());
            }
            return result;
        }

        int totalElements = m * n;
        int[][] shiftedGrid = new int[m][n];

        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                int newFlatIndex = r * n + c;
                int oldFlatIndex = (newFlatIndex - k % totalElements + totalElements) % totalElements;

                int oldRow = oldFlatIndex / n;
                int oldCol = oldFlatIndex % n;

                shiftedGrid[r][c] = grid[oldRow][oldCol];
            }
        }

        List<List<Integer>> result = new ArrayList<>();
        for (int r = 0; r < m; r++) {
            List<Integer> row = new ArrayList<>();
            for (int c = 0; c < n; c++) {
                row.add(shiftedGrid[r][c]);
            }
            result.add(row);
        }

        return result;
    }
}