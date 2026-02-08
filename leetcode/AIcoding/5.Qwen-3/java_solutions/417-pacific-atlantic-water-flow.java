public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> pacificAtlantic(int[][] matrix) {
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return new ArrayList<>();
        }

        int rows = matrix.length;
        int cols = matrix[0].length;

        boolean[][] pacific = new boolean[rows][cols];
        boolean[][] atlantic = new boolean[rows][cols];

        for (int i = 0; i < rows; i++) {
            dfs(matrix, i, 0, pacific);
            dfs(matrix, i, cols - 1, atlantic);
        }

        for (int j = 0; j < cols; j++) {
            dfs(matrix, 0, j, pacific);
            dfs(matrix, rows - 1, j, atlantic);
        }

        List<List<Integer>> result = new ArrayList<>();

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (pacific[i][j] && atlantic[i][j]) {
                    List<Integer> cell = new ArrayList<>();
                    cell.add(i);
                    cell.add(j);
                    result.add(cell);
                }
            }
        }

        return result;
    }

    private void dfs(int[][] matrix, int i, int j, boolean[][] visited) {
        if (visited[i][j]) {
            return;
        }

        visited[i][j] = true;

        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        for (int[] dir : directions) {
            int ni = i + dir[0];
            int nj = j + dir[1];

            if (ni >= 0 && ni < matrix.length && nj >= 0 && nj < matrix[0].length && matrix[ni][nj] >= matrix[i][j]) {
                dfs(matrix, ni, nj, visited);
            }
        }
    }
}
}