public class Solution {

import java.util.*;

public class NeighborSumService {
    private int[][] grid;
    private int rows;
    private int cols;

    public NeighborSumService(int[][] grid) {
        this.grid = grid;
        this.rows = grid.length;
        this.cols = grid[0].length;
    }

    public int[] neighborSum(int[] query) {
        int row = query[0];
        int col = query[1];
        int sum = 0;
        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        for (int[] dir : directions) {
            int newRow = row + dir[0];
            int newCol = col + dir[1];
            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols) {
                sum += grid[newRow][newCol];
            }
        }
        return new int[]{sum};
    }
}
}