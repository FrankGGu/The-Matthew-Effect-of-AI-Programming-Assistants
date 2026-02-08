class Solution {
    public int countNegatives(int[][] grid) {
        int count = 0;
        int m = grid.length;
        int n = grid[0].length;

        // Start from the top-right corner of the matrix.
        // `colPointer` will track the rightmost column index
        // where negative numbers might start in the current row.
        // It's initialized to the last column index (n-1).
        // Due to the sorted property, this pointer only moves left or stays.
        int colPointer = n - 1;

        // Iterate through each row.
        for (int row = 0; row < m; row++) {
            // In each row, move `colPointer` leftwards as long as
            // the element at `grid[row][colPointer]` is negative.
            // This finds the boundary between non-negative and negative numbers.
            while (colPointer >= 0 && grid[row][colPointer] < 0) {
                colPointer--;
            }
            // After the while loop, `colPointer` is either -1 (meaning all elements
            // in the current row are negative) or it points to the index of the
            // rightmost non-negative number in the current row.
            // The number of negative elements in the current row is `n - 1 - colPointer`.
            // For example, if colPointer is 2, and n is 4, elements at index 3 are negative.
            // If colPointer is -1, all n elements are negative. (4 - 1 - (-1) = 4).
            count += (n - 1 - colPointer);
        }

        return count;
    }
}