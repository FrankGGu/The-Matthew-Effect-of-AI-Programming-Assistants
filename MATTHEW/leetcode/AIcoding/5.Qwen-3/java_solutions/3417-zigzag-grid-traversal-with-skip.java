public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> zigzagGridTraversal(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        List<Integer> result = new ArrayList<>();
        boolean isLeftToRight = true;
        int row = 0, col = 0;

        while (row < rows && col < cols) {
            if (isLeftToRight) {
                while (row >= 0 && col < cols) {
                    result.add(grid[row][col]);
                    row--;
                    col++;
                }
                row++;
                if (col >= cols) {
                    row++;
                    col = cols - 1;
                } else {
                    row = 0;
                }
            } else {
                while (row < rows && col >= 0) {
                    result.add(grid[row][col]);
                    row++;
                    col--;
                }
                col++;
                if (row >= rows) {
                    col++;
                    row = rows - 1;
                } else {
                    col = 0;
                }
            }
            isLeftToRight = !isLeftToRight;
        }

        return result;
    }
}
}