import java.util.*;

class Solution {

    public long maxValueSum(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        // If m is greater than n, transpose the grid to ensure m <= n.
        // This optimizes the C(m,3)*n complexity to min(m,n)^3 * max(m,n).
        if (m > n) {
            int[][] transposedGrid = new int[n][m];
            for (int r = 0; r < m; r++) {
                for (int c = 0; c < n; c++) {
                    transposedGrid[c][r] = grid[r][c];
                }
            }
            grid = transposedGrid;
            int temp = m;
            m = n;
            n = temp;
        }

        long maxOverallSum = 0;

        // Iterate over all combinations of 3 distinct rows (r1, r2, r3)
        // C(m, 3) combinations.
        for (int r1 = 0; r1 < m; r1++) {
            for (int r2 = r1 + 1; r2 < m; r2++) {
                for (int r3 = r2 + 1; r3 < m; r3++) {
                    // For these 3 fixed rows, find the maximum sum by picking 3 distinct columns (c_a, c_b, c_c)
                    // and assigning them to (r1, r2, r3) to maximize grid[r_p][c_a] + grid[r_q][c_b] + grid[r_s][c_c]
                    // where (r_p, r_q, r_s) is a permutation of (r1, r2, r3).
                    // This is equivalent to finding max(X_ca + Y_cb + Z_cc) where X_j = grid[r1][j], Y_j = grid[r2][j], Z_j = grid[r3][j]
                    // and c_a, c_b, c_c are distinct.

                    long currentMaxForRows = 0;

                    // Store top values for Y_j and Z_j for quick lookups.
                    // We need up to 4 top values to handle potential column conflicts.
                    // (value, column_index)
                    List<long[]> topY = new ArrayList<>();
                    List<long[]> topZ = new ArrayList<>();

                    for (int j = 0; j < n; j++) {
                        topY.add(new long[]{(long) grid[r2][j], j});
                        topZ.add(new long[]{(long) grid[r3][j], j});
                    }

                    // Sort in descending order by value
                    topY.sort((a, b) -> Long.compare(b[0], a[0]));
                    topZ.sort((a, b) -> Long.compare(b[0], a[0]));

                    // Iterate over c_a for the first rook (r1, c_a)
                    for (int ca = 0; ca < n; ca++) {
                        long valX = grid[r1][ca];
                        long maxYZPairExceptCa = -1; // Max sum of Y_cb + Z_cc where cb, cc are distinct and not ca

                        // Find the best Y_cb + Z_cc pair, excluding columns ca.
                        // Iterate through a small number of top candidates to find the best pair.
                        // A small constant like 4-6 is usually sufficient to avoid conflicts.
                        int limit = Math.min(n, 6); // Check up to top 6 elements for Y and Z

                        for (int i = 0; i < limit; i++) {
                            long valY = topY.get(i)[0];
                            int cb = (int) topY.get(i)[1];

                            if (cb == ca) continue; // Column conflict with ca

                            for (int k = 0; k < limit; k++) {
                                long valZ = topZ.get(k)[0];
                                int cc = (int) topZ.get(k)[1];

                                if (cc == ca || cc == cb) continue; // Column conflict with ca or cb

                                maxYZPairExceptCa = Math.max(maxYZPairExceptCa, valY + valZ);
                                // Optimization: if we found a valid pair, we can break early from inner loop
                                // because topY and topZ are sorted.
                                // However, we need to ensure we find the *best* pair, so checking more is safer.
                            }
                        }

                        // If no valid YZ pair was found (e.g., n < 3 or all top candidates conflict),
                        // maxYZPairExceptCa remains -1. In this case, this combination of ca is invalid.
                        if (maxYZPairExceptCa != -1) {
                            currentMaxForRows = Math.max(currentMaxForRows, valX + maxYZPairExceptCa);
                        }
                    }
                    maxOverallSum = Math.max(maxOverallSum, currentMaxForRows);
                }
            }
        }

        return maxOverallSum;
    }
}