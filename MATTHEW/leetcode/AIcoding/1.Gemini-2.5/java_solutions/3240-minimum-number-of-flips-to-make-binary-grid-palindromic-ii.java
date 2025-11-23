import java.util.ArrayList;
import java.util.List;

class Solution {
    public int minimumFlips(int[][] grid) {
        int R = grid.length;
        int C = grid[0].length;
        int totalFlips = 0;

        // Iterate through the top-left quadrant (including middle row/column if they exist)
        // (R - 1) / 2 covers indices from 0 up to floor((R-1)/2)
        // For R=3, (3-1)/2 = 1, so r goes 0, 1.
        // For R=2, (2-1)/2 = 0, so r goes 0.
        for (int r = 0; r <= (R - 1) / 2; r++) {
            for (int c = 0; c <= (C - 1) / 2; c++) {
                List<Integer> groupValues = new ArrayList<>();

                // The cell (r, c) itself
                groupValues.add(grid[r][c]);

                // The symmetric cell (r, C-1-c) across the vertical mid-axis
                // Add if (c, C-1-c) are distinct coordinates
                if (c != C - 1 - c) {
                    groupValues.add(grid[r][C - 1 - c]);
                }

                // The symmetric cell (R-1-r, c) across the horizontal mid-axis
                // Add if (r, R-1-r) are distinct coordinates
                if (r != R - 1 - r) {
                    groupValues.add(grid[R - 1 - r][c]);

                    // The symmetric cell (R-1-r, C-1-c) across both axes
                    // Add if (c, C-1-c) are distinct coordinates (to avoid adding (R-1-r, c) again if c is mid-column)
                    if (c != C - 1 - c) {
                        groupValues.add(grid[R - 1 - r][C - 1 - c]);
                    }
                }

                // Count zeros and ones in the current group of symmetric cells
                int count0 = 0;
                int count1 = 0;
                for (int val : groupValues) {
                    if (val == 0) {
                        count0++;
                    } else {
                        count1++;
                    }
                }

                // To make all cells in the group the same, we flip the minority.
                // The number of flips is the count of the less frequent value.
                totalFlips += Math.min(count0, count1);
            }
        }

        return totalFlips;
    }
}