class Solution {
    public int kthSmallest(int[][] matrix, int k) {
        int n = matrix.length;
        int low = matrix[0][0];
        int high = matrix[n - 1][n - 1];
        int ans = -1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            int count = countLessEqual(matrix, mid);

            if (count < k) {
                low = mid + 1;
            } else {
                ans = mid; // This mid could be the answer, or we might find a smaller one
                high = mid - 1;
            }
        }
        return ans;
    }

    private int countLessEqual(int[][] matrix, int target) {
        int n = matrix.length;
        int count = 0;
        int row = 0;
        int col = n - 1;

        while (row < n && col >= 0) {
            if (matrix[row][col] <= target) {
                // All elements in this row from matrix[row][0] to matrix[row][col] are <= target
                count += (col + 1);
                row++; // Move to the next row
            } else {
                // matrix[row][col] is too large, move left in the current row
                col--;
            }
        }
        return count;
    }
}