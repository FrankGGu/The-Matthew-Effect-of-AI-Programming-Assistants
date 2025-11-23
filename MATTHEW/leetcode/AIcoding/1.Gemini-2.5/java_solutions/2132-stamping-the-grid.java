class Solution {
    public boolean isPrintable(int[][] grid, int stampHeight, int stampWidth) {
        int m = grid.length;
        int n = grid[0].length;

        // Step 1: Compute 2D prefix sum of the original grid.
        // prefixSum[r][c] stores the sum of grid[x][y] for 0 <= x < r and 0 <= y < c.
        int[][] prefixSum = new int[m + 1][n + 1];
        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                prefixSum[r + 1][c + 1] = grid[r][c] + prefixSum[r][c + 1] + prefixSum[r + 1][c] - prefixSum[r][c];
            }
        }

        // Step 2: Determine 'canPlaceStamp[r][c]'.
        // canPlaceStamp[r][c] = 1 if a stamp can be placed with its top-left corner at (r, c).
        // This is possible if the rectangle from (r, c) to (r + stampHeight - 1, c + stampWidth - 1)
        // contains only 0s in the original grid.
        int[][] canPlaceStamp = new int[m][n];
        for (int r = 0; r <= m - stampHeight; r++) {
            for (int c = 0; c <= n - stampWidth; c++) {
                // Calculate sum of the rectangle using prefix sums
                int sum = prefixSum[r + stampHeight][c + stampWidth] 
                          - prefixSum[r][c + stampWidth] 
                          - prefixSum[r + stampHeight][c] 
                          + prefixSum[r][c];

                if (sum == 0) { // If sum is 0, all cells in the rectangle are 0s
                    canPlaceStamp[r][c] = 1;
                }
            }
        }

        // Step 3: Use 'canPlaceStamp' to build a 2D difference array for coverage.
        // The 'diff' array helps to efficiently mark all cells covered by possible stamp placements.
        int[][] diff = new int[m + 1][n + 1];
        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                if (canPlaceStamp[r][c] == 1) {
                    // Mark the top-left corner of the stamp
                    diff[r][c]++;
                    // Mark the boundaries where the stamp's effect ends
                    if (r + stampHeight < m + 1) diff[r + stampHeight][c]--;
                    if (c + stampWidth < n + 1) diff[r][c + stampWidth]--;
                    if (r + stampHeight < m + 1 && c + stampWidth < n + 1) diff[r + stampHeight][c + stampWidth]++;
                }
            }
        }

        // Step 4: Compute 'coveredCount' (actual coverage counts) from the 'diff' array.
        // coveredCount[r][c] will store the number of stamps that cover cell (r, c).
        int[][] coveredCount = new int[m][n];
        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                coveredCount[r][c] = diff[r][c];
                if (r > 0) coveredCount[r][c] += coveredCount[r - 1][c];
                if (c > 0) coveredCount[r][c] += coveredCount[r][c - 1];
                if (r > 0 && c > 0) coveredCount[r][c] -= coveredCount[r - 1][c - 1];
            }
        }

        // Step 5: Verify that all original '0' cells are covered by at least one stamp.
        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                if (grid[r][c] == 0 && coveredCount[r][c] == 0) {
                    // If an original '0' cell is not covered by any stamp, it's impossible.
                    return false;
                }
            }
        }

        // All original '0' cells are covered.
        return true;
    }
}