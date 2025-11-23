class Solution {
    public int maxScore(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        // minVal[i][j] stores the minimum value in the subgrid from (0,0) to (i,j).
        int[][] minVal = new int[m][n];

        // Initialize maxScore to the smallest possible integer value.
        // The score can be negative if all valid differences are negative.
        int maxScore = Integer.MIN_VALUE;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                // Calculate currentMinFromPreviousRegion:
                // This is the minimum value among all cells (r1, c1) such that
                // r1 <= i, c1 <= j, AND (r1, c1) != (i, j).
                // This is effectively the minimum value in the subgrid formed by
                // cells strictly above grid[i][j] or strictly to the left of grid[i][j].

                int currentMinFromPreviousRegion = Integer.MAX_VALUE;
                if (i > 0) {
                    currentMinFromPreviousRegion = Math.min(currentMinFromPreviousRegion, minVal[i-1][j]);
                }
                if (j > 0) {
                    currentMinFromPreviousRegion = Math.min(currentMinFromPreviousRegion, minVal[i][j-1]);
                }

                // If currentMinFromPreviousRegion is not Integer.MAX_VALUE, it means
                // there is at least one valid cell (r1, c1) before (i,j) to form a difference.
                if (currentMinFromPreviousRegion != Integer.MAX_VALUE) {
                    maxScore = Math.max(maxScore, grid[i][j] - currentMinFromPreviousRegion);
                }

                // Update minVal[i][j] for future calculations.
                // minVal[i][j] is the minimum of the current cell grid[i][j]
                // and the minimums from its top and left neighbors (which already store
                // minimums of their respective top-left subgrids).
                minVal[i][j] = grid[i][j]; // Start with the current cell's value
                if (i > 0) {
                    minVal[i][j] = Math.min(minVal[i][j], minVal[i-1][j]);
                }
                if (j > 0) {
                    minVal[i][j] = Math.min(minVal[i][j], minVal[i][j-1]);
                }
            }
        }

        return maxScore;
    }
}