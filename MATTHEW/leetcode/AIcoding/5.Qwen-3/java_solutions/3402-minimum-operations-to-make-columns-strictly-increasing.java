public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int operations = 0;

        for (int j = 1; j < cols; j++) {
            for (int i = 0; i < rows; i++) {
                if (grid[i][j] > grid[i][j - 1]) {
                    continue;
                } else {
                    int needed = grid[i][j - 1] + 1;
                    operations += needed - grid[i][j];
                    grid[i][j] = needed;
                }
            }
        }

        return operations;
    }
}
}