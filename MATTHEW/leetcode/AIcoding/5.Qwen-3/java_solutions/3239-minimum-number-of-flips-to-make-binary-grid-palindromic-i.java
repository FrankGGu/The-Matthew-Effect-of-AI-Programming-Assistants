public class Solution {

import java.util.*;

public class Solution {
    public int minFlips(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int flips = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols / 2; j++) {
                int oppositeJ = cols - 1 - j;
                if (grid[i][j] != grid[i][oppositeJ]) {
                    flips++;
                }
            }
        }

        for (int j = 0; j < cols; j++) {
            for (int i = 0; i < rows / 2; i++) {
                int oppositeI = rows - 1 - i;
                if (grid[i][j] != grid[oppositeI][j]) {
                    flips++;
                }
            }
        }

        return flips;
    }
}
}