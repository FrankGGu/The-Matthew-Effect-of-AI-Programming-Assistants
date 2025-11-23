public class Solution {

import java.util.Arrays;

public class Solution {
    public int maxSpending(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int[] flat = new int[rows * cols];
        int index = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                flat[index++] = grid[i][j];
            }
        }
        Arrays.sort(flat);
        int sum = 0;
        for (int i = 0; i < flat.length; i++) {
            sum += flat[i] * (i + 1);
        }
        return sum;
    }
}
}