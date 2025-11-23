import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int maxIncreasingCells(int[][] matrix) {
        int m = matrix.length;
        int n = matrix[0].length;

        // Step 1: Collect all cells with their values and coordinates
        // Each element is [value, row, col]
        List<int[]> cells = new ArrayList<>();
        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                cells.add(new int[]{matrix[r][c], r, c});
            }
        }

        // Step 2: Sort cells by their values in ascending order
        Collections.sort(cells, (a, b) -> a[0] - b[0]);

        // maxRow[r] stores the maximum length of a strictly increasing path
        // ending at any cell in row 'r' that has been processed so far (i.e., with a smaller value).
        int[] maxRow = new int[m];
        // maxCol[c] stores the maximum length of a strictly increasing path
        // ending at any cell in column 'c' that has been processed so far.
        int[] maxCol = new int[n];

        int overallMaxLen = 0;

        int i = 0;
        while (i < cells.size()) {
            int currentVal = cells.get(i)[0];
            List<int[]> currentBatch = new ArrayList<>();

            // Collect all cells that have the current value
            while (i < cells.size() && cells.get(i)[0] == currentVal) {
                currentBatch.add(cells.get(i));
                i++;
            }

            // Step 3: Calculate DP values for cells in the current batch
            // These calculations must use maxRow and maxCol values that reflect
            // paths ending at cells with *strictly smaller* values.
            // Store calculated DP values temporarily for this batch.
            List<int[]> dpValuesForBatch = new ArrayList<>(); // Stores [r, c, calculated_dp_value]
            for (int[] cell : currentBatch) {
                int r = cell[1];
                int c = cell[2];

                // A path can end at (r, c) by extending a path from
                // any cell in the same row 'r' or same column 'c'
                // with a strictly smaller value.
                // If no such path exists, the length is 1 (the cell itself).
                int currentDp = 1 + Math.max(maxRow[r], maxCol[c]);

                dpValuesForBatch.add(new int[]{r, c, currentDp});
                overallMaxLen = Math.max(overallMaxLen, currentDp);
            }

            // Step 4: After all DP values for the current batch are calculated,
            // update maxRow and maxCol. This ensures that updates for cells
            // with `currentVal` do not affect other cells with the same `currentVal`.
            for (int[] dpEntry : dpValuesForBatch) {
                int r = dpEntry[0];
                int c = dpEntry[1]; // c is not strictly needed here, but stored for consistency
                int dpVal = dpEntry[2];
                maxRow[r] = Math.max(maxRow[r], dpVal);
                maxCol[c] = Math.max(maxCol[c], dpVal);
            }
        }

        return overallMaxLen;
    }
}