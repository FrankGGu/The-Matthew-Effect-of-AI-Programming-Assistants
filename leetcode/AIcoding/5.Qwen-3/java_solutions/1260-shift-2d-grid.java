public class Solution {

import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<List<Integer>> shiftGrid(int[][] grid, int k) {
        int rows = grid.length;
        int cols = grid[0].length;
        int total = rows * cols;
        k = k % total;

        List<List<Integer>> result = new ArrayList<>();
        for (int i = 0; i < rows; i++) {
            result.add(new ArrayList<>());
        }

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                int newIndex = (i * cols + j + k) % total;
                int newI = newIndex / cols;
                int newJ = newIndex % cols;
                result.get(newI).add(grid[i][j]);
            }
        }

        return result;
    }
}
}