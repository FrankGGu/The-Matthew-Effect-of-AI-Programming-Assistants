import java.util.Arrays;

class Solution {
    // Assuming values in grid are within a small range, e.g., 0 to 100.
    // This constant should be adjusted if the actual problem constraints for grid[i][j] are different.
    private static final int MAX_VAL = 100;

    public int[][] minimumAbsoluteDifference(int[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;

        int[][] answer = new int[m - k + 1][n - k + 1];

        // This array will store counts of numbers in the current k x k submatrix.
        // Its size is MAX_VAL + 1 to accommodate values from 0 up to MAX_VAL.
        int[] windowCounts = new int[MAX_VAL + 1];

        for (int r = 0; r <= m - k; r++) {
            // For each new row block 'r', we need to initialize the windowCounts
            // for the first k x k submatrix (top-left at (r, 0)).
            // This involves clearing the counts and then populating them.
            Arrays.fill(windowCounts, 0);

            // Populate windowCounts for the first k x k submatrix at (r, 0)
            for (int i = r; i < r + k; i++) {
                for (int j = 0; j < k; j++) {
                    windowCounts[grid[i][j]]++;
                }
            }

            // Calculate and store the result for the first window in this row block (r, 0)
            answer[r][0] = getMinAbsDiff(windowCounts);

            // Now, slide the window horizontally for the current row block 'r'
            for (int c = 1; c <= n - k; c++) {
                // Remove the leftmost column of the previous window (column c-1)
                for (int i = r; i < r + k; i++) {
                    windowCounts[grid[i][c - 1]]--;
                }
                // Add the rightmost column for the current window (column c+k-1)
                for (int i = r; i < r + k; i++) {
                    windowCounts[grid[i][c + k - 1]]++;
                }
                // Calculate and store the result for the current window (r, c)
                answer[r][c] = getMinAbsDiff(windowCounts);
            }
        }

        return answer;
    }

    // Helper method to calculate the minimum absolute difference from the frequency array
    private int getMinAbsDiff(int[] counts) {
        int minDiff = Integer.MAX_VALUE;
        int prevVal = -1; // Stores the previously seen value with count > 0

        for (int i = 0; i <= MAX_VAL; i++) {
            if (counts[i] > 0) {
                // If there are duplicate occurrences of the same number in the window,
                // the minimum absolute difference is 0.
                if (counts[i] > 1) {
                    return 0;
                }
                // If this is not the first distinct value encountered, calculate difference
                // with the previous distinct value.
                if (prevVal != -1) {
                    minDiff = Math.min(minDiff, i - prevVal);
                }
                // Update prevVal to the current distinct value
                prevVal = i;
            }
        }
        // If minDiff is still Integer.MAX_VALUE, it means there was only one distinct number
        // in the window (e.g., for k=1 or all numbers are the same but distinct counts are 1).
        // In such cases, the minimum absolute difference is considered 0.
        return minDiff == Integer.MAX_VALUE ? 0 : minDiff;
    }
}