class Solution {
    public int[] findPeakGrid(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;

        int low = 0;
        int high = m - 1;

        while (low <= high) {
            int midRow = low + (high - low) / 2;

            // Find the maximum element in the midRow
            int maxCol = 0;
            for (int j = 1; j < n; j++) {
                if (mat[midRow][j] > mat[midRow][maxCol]) {
                    maxCol = j;
                }
            }

            int currentVal = mat[midRow][maxCol];

            // Check neighbors (using -1 as a sentinel for out-of-bounds,
            // which is smaller than any valid matrix element as per problem constraints 1 <= mat[i][j] <= 10^5)
            int upVal = (midRow > 0) ? mat[midRow - 1][maxCol] : -1;
            int downVal = (midRow < m - 1) ? mat[midRow + 1][maxCol] : -1;

            // If currentVal is strictly greater than both its top and bottom neighbors,
            // it's a peak (it's already greater than left/right because it's the max in its row).
            if (currentVal > upVal && currentVal > downVal) {
                return new int[]{midRow, maxCol};
            }
            // If currentVal is smaller than its top neighbor, a peak must exist in the upper half
            else if (currentVal < upVal) {
                high = midRow - 1;
            }
            // If currentVal is smaller than its bottom neighbor, a peak must exist in the lower half
            else { // currentVal < downVal
                low = midRow + 1;
            }
        }

        // This line should theoretically not be reached as the problem guarantees a peak exists.
        return new int[]{-1, -1}; 
    }
}