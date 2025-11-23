public class Solution {

import java.util.*;

public class Solution {
    public int minFlips(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int flips = 0;

        for (int i = 0; i < rows / 2; i++) {
            for (int j = 0; j < cols / 2; j++) {
                int a = grid[i][j];
                int b = grid[i][cols - 1 - j];
                int c = grid[rows - 1 - i][j];
                int d = grid[rows - 1 - i][cols - 1 - j];

                int[] counts = {a, b, c, d};
                Arrays.sort(counts);
                int ones = counts[3] + counts[2];
                int zeros = counts[1] + counts[0];

                if (ones > zeros) {
                    flips += zeros;
                } else {
                    flips += ones;
                }
            }
        }

        if (rows % 2 == 1 && cols % 2 == 1) {
            int mid = grid[rows / 2][cols / 2];
            if (mid == 0) {
                flips++;
            }
        }

        return flips;
    }
}
}