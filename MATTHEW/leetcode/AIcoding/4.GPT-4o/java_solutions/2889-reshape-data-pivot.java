import java.util.*;

public class Solution {
    public int[][] pivotGrid(int[][] grid, int r, int c) {
        int m = grid.length, n = grid[0].length;
        if (m * n != r * c) return new int[][]{};

        int[][] result = new int[r][c];
        for (int i = 0; i < m * n; i++) {
            result[i / c][i % c] = grid[i / n][i % n];
        }
        return result;
    }
}