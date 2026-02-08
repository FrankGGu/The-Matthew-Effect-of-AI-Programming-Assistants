import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> goodSubsetofBinaryMatrix(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        // According to the problem description:
        // "A subset of rows is good if the bitwise OR of all elements in the subset is 0,
        // and the bitwise AND of all elements in the subset is 0."
        //
        // If the bitwise OR of all elements in a subset of rows is 0, it implies that
        // every single element (cell value) in all chosen rows must be 0.
        // (Since elements are binary, if any element is 1, the OR would be 1, not 0).
        //
        // If every element in all chosen rows is 0, then the bitwise AND of all these
        // elements will also naturally be 0.
        //
        // Therefore, the condition simplifies to finding a subset of rows where all
        // cells in those rows are 0. The simplest such subset is a single row
        // that consists entirely of zeros. If such a row exists, it forms a good subset.
        // If multiple such rows exist, any one of them is a valid answer.
        // If no such row exists, then no combination of rows can satisfy the condition,
        // as any chosen row would contain at least one '1', making the overall OR non-zero.

        // Iterate through each row to find if any row consists entirely of zeros.
        for (int i = 0; i < m; i++) {
            boolean allZeros = true;
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    allZeros = false;
                    break; // Found a '1', this row is not all zeros.
                }
            }
            if (allZeros) {
                // If a row of all zeros is found, return its index as a good subset.
                List<Integer> result = new ArrayList<>();
                result.add(i);
                return result;
            }
        }

        // If no single row of all zeros is found after checking all rows,
        // then no good subset exists under the given problem description.
        return new ArrayList<>();
    }
}