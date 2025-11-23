public class Solution {

import java.util.*;

public class Solution {
    public int[] findBall(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[] result = new int[n];

        for (int col = 0; col < n; col++) {
            int currentCol = col;
            for (int row = 0; row < m; row++) {
                int nextCol = currentCol + grid[row][currentCol];
                if (nextCol < 0 || nextCol >= n) {
                    currentCol = -1;
                    break;
                }
                if (grid[row][currentCol] != grid[row][nextCol]) {
                    currentCol = -1;
                    break;
                }
                currentCol = nextCol;
            }
            result[col] = currentCol;
        }

        return result;
    }
}
}