class Solution {
    public boolean equalSumGridPartition(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        // Precompute 2D prefix sums
        // P[i][j] stores the sum of elements in the rectangle from (0,0) to (i-1, j-1)
        long[][] P = new long[m + 1][n + 1];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                P[i + 1][j + 1] = grid[i][j] + P[i][j + 1] + P[i + 1][j] - P[i][j];
            }
        }

        // Iterate all possible horizontal cut positions (r)
        // r represents the row index where the horizontal cut is made.
        // It must be between 1 and m-1 (inclusive), to ensure valid top and bottom parts.
        for (int r = 1; r < m; r++) {
            // Iterate all possible vertical cut positions (c)
            // c represents the column index where the vertical cut is made.
            // It must be between 1 and n-1 (inclusive), to ensure valid left and right parts.
            for (int c = 1; c < n; c++) {
                // Calculate the sums of the four resulting sub-rectangles:
                // 1. Top-Left: from (0,0) to (r-1, c-1)
                long s1 = getRectSum(P, 0, 0, r - 1, c - 1);
                // 2. Top-Right: from (0,c) to (r-1, n-1)
                long s2 = getRectSum(P, 0, c, r - 1, n - 1);
                // 3. Bottom-Left: from (r,0) to (m-1, c-1)
                long s3 = getRectSum(P, r, 0, m - 1, c - 1);
                // 4. Bottom-Right: from (r,c) to (m-1, n-1)
                long s4 = getRectSum(P, r, c, m - 1, n - 1);

                // Check if all four sums are equal
                if (s1 == s2 && s2 == s3 && s3 == s4) {
                    return true;
                }
            }
        }

        // If no such partition is found after checking all possibilities
        return false;
    }

    private long getRectSum(long[][] P, int r1, int c1, int r2, int c2) {
        return P[r2 + 1][c2 + 1] - P[r1][c2 + 1] - P[r2 + 1][c1] + P[r1][c1];
    }
}