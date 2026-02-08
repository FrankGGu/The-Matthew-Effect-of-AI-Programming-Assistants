class Solution {
    public long countPyramids(int[][] grid) {
        int R = grid.length;
        int C = grid[0].length;

        // dp_pyramid[i][j] stores the maximum height H of a regular pyramid with apex (i, j).
        // A pyramid of height H means it extends H-1 rows downwards from (i, j).
        // If H=1, it's just the cell (i, j) itself.
        int[][] dp_pyramid = new int[R][C];
        long totalCount = 0;

        // Calculate regular pyramids (scanning from bottom-right to top-left)
        // dp_pyramid[i][j] depends on cells in row i+1, so we iterate i from R-1 down to 0.
        for (int i = R - 1; i >= 0; i--) {
            for (int j = 0; j < C; j++) {
                if (grid[i][j] == 0) {
                    dp_pyramid[i][j] = 0;
                } else { // grid[i][j] == 1
                    // Base case: a pyramid of height 1 (just the cell itself)
                    // If it's the last row, or on the leftmost/rightmost column,
                    // it cannot form a base of width 3 below it, so its maximum pyramid height is 1.
                    if (i == R - 1 || j == 0 || j == C - 1) {
                        dp_pyramid[i][j] = 1;
                    } else {
                        // A pyramid of height H at (i,j) requires (i+1, j-1), (i+1, j), (i+1, j+1)
                        // to be apexes of pyramids of height H-1.
                        // The current cell (i,j) contributes 1 to the height, plus the minimum height
                        // of the three cells below it.
                        dp_pyramid[i][j] = 1 + Math.min(dp_pyramid[i + 1][j - 1], 
                                                        Math.min(dp_pyramid[i + 1][j], 
                                                                 dp_pyramid[i + 1][j + 1]));
                    }
                }
                // According to problem examples, we count pyramids of height > 1.
                // If dp_pyramid[i][j] = H, it means it forms H-1 pyramids of height > 1
                // (specifically, pyramids of height 2, 3, ..., H).
                totalCount += Math.max(0, dp_pyramid[i][j] - 1);
            }
        }

        // dp_inv_pyramid[i][j] stores the maximum height H of an inverse pyramid with apex (i, j).
        // An inverse pyramid of height H means it extends H-1 rows upwards from (i, j).
        // If H=1, it's just the cell (i, j) itself.
        int[][] dp_inv_pyramid = new int[R][C];

        // Calculate inverse pyramids (scanning from top-left to bottom-right)
        // dp_inv_pyramid[i][j] depends on cells in row i-1, so we iterate i from 0 up to R-1.
        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                if (grid[i][j] == 0) {
                    dp_inv_pyramid[i][j] = 0;
                } else { // grid[i][j] == 1
                    // Base case: an inverse pyramid of height 1 (just the cell itself)
                    // If it's the first row, or on the leftmost/rightmost column,
                    // it cannot form a base of width 3 above it, so its maximum inverse pyramid height is 1.
                    if (i == 0 || j == 0 || j == C - 1) {
                        dp_inv_pyramid[i][j] = 1;
                    } else {
                        // An inverse pyramid of height H at (i,j) requires (i-1, j-1), (i-1, j), (i-1, j+1)
                        // to be apexes of inverse pyramids of height H-1.
                        // The current cell (i,j) contributes 1 to the height, plus the minimum height
                        // of the three cells above it.
                        dp_inv_pyramid[i][j] = 1 + Math.min(dp_inv_pyramid[i - 1][j - 1], 
                                                            Math.min(dp_inv_pyramid[i - 1][j], 
                                                                     dp_inv_pyramid[i - 1][j + 1]));
                    }
                }
                // Add to totalCount only inverse pyramids of height > 1.
                // If dp_inv_pyramid[i][j] = H, it means it forms H-1 inverse pyramids of height > 1.
                totalCount += Math.max(0, dp_inv_pyramid[i][j] - 1);
            }
        }

        return totalCount;
    }
}