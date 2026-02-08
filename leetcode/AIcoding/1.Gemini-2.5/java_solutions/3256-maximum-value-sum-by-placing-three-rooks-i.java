import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int maximumValueSum(int[][] grid) {
        int n = grid.length;

        // max_val_above[r][c] stores the maximum value in column 'c' from rows 0 to r-1.
        // max_val_above[r][c] = max(grid[0][c], ..., grid[r-1][c])
        int[][] max_val_above = new int[n][n];

        // max_val_below[r][c] stores the maximum value in column 'c' from rows r+1 to n-1.
        // max_val_below[r][c] = max(grid[r+1][c], ..., grid[n-1][c])
        int[][] max_val_below = new int[n][n];

        // Initialize with a very small value, as grid values are positive.
        // Using Integer.MIN_VALUE as a sentinel for no valid maximum.
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                max_val_above[i][j] = Integer.MIN_VALUE;
                max_val_below[i][j] = Integer.MIN_VALUE;
            }
        }

        // Compute max_val_above
        for (int c = 0; c < n; c++) {
            // max_val_above[0][c] remains Integer.MIN_VALUE as there are no rows above row 0.
            for (int r = 1; r < n; r++) {
                max_val_above[r][c] = Math.max(max_val_above[r - 1][c], grid[r - 1][c]);
            }
        }

        // Compute max_val_below
        for (int c = 0; c < n; c++) {
            // max_val_below[n-1][c] remains Integer.MIN_VALUE as there are no rows below row n-1.
            for (int r = n - 2; r >= 0; r--) {
                max_val_below[r][c] = Math.max(max_val_below[r + 1][c], grid[r + 1][c]);
            }
        }

        long overallMaxSum = 0; // Use long for sum to avoid overflow, though problem constraints suggest int is fine (3 * 10^5).

        // Iterate through each possible row 'r' for the second (middle) rook
        for (int r = 0; r < n; r++) {
            // Collect candidates for the first rook (from rows < r)
            List<CellInfo> candidatesAbove = new ArrayList<>();
            for (int j = 0; j < n; j++) {
                if (max_val_above[r][j] != Integer.MIN_VALUE) {
                    candidatesAbove.add(new CellInfo(max_val_above[r][j], j));
                }
            }
            // Sort candidates by value in descending order
            Collections.sort(candidatesAbove, (a, b) -> b.value - a.value);

            // Collect candidates for the third rook (from rows > r)
            List<CellInfo> candidatesBelow = new ArrayList<>();
            for (int j = 0; j < n; j++) {
                if (max_val_below[r][j] != Integer.MIN_VALUE) {
                    candidatesBelow.add(new CellInfo(max_val_below[r][j], j));
                }
            }
            // Sort candidates by value in descending order
            Collections.sort(candidatesBelow, (a, b) -> b.value - a.value);

            // Iterate through each possible column 'c' for the second (middle) rook
            for (int c = 0; c < n; c++) {
                long currentSum = grid[r][c];

                // Find the best two rooks from candidatesAbove and candidatesBelow
                // such that their columns are distinct from 'c' and from each other.
                // We check a small number of top candidates (e.g., 3) to ensure we find a valid pair.
                // The number 3 is chosen because if the top 2 candidates are blocked (by 'c' or each other),
                // the 3rd might still be valid.
                for (int i_a = 0; i_a < Math.min(candidatesAbove.size(), 3); i_a++) {
                    CellInfo candA = candidatesAbove.get(i_a);
                    int valA = candA.value;
                    int colA = candA.colIndex;

                    // If this candidate's column is the same as the middle rook's column, skip.
                    if (colA == c) {
                        continue;
                    }

                    for (int i_b = 0; i_b < Math.min(candidatesBelow.size(), 3); i_b++) {
                        CellInfo candB = candidatesBelow.get(i_b);
                        int valB = candB.value;
                        int colB = candB.colIndex;

                        // If this candidate's column is the same as the middle rook's column, skip.
                        // If this candidate's column is the same as the first rook's column, skip.
                        if (colB == c || colB == colA) {
                            continue;
                        }

                        // Found three valid rooks with distinct rows and columns
                        overallMaxSum = Math.max(overallMaxSum, currentSum + valA + valB);
                    }
                }
            }
        }

        return (int) overallMaxSum;
    }

    // Helper class to store value and column index
    private static class CellInfo {
        int value;
        int colIndex;

        public CellInfo(int value, int colIndex) {
            this.value = value;
            this.colIndex = colIndex;
        }
    }
}