class Solution {
    public int matrixScore(int[][] grid) {
        int R = grid.length;
        int C = grid[0].length;

        // Step 1: Ensure all cells in the first column are 1s.
        // If grid[i][0] is 0, flip row i. This is always optimal for the most significant bit.
        for (int i = 0; i < R; i++) {
            if (grid[i][0] == 0) {
                // Flip row i
                for (int j = 0; j < C; j++) {
                    grid[i][j] = 1 - grid[i][j];
                }
            }
        }

        // Calculate the initial score from the first column.
        // After step 1, all cells in the first column are 1s.
        // Each of these contributes 2^(C-1) to the total score.
        int score = R * (1 << (C - 1));

        // Step 2: For each subsequent column (j from 1 to C-1), decide whether to flip it.
        // We want to maximize the number of 1s in each column to maximize its contribution.
        // Flipping a column does not affect the first column (which is already optimized)
        // nor does it affect decisions for previous columns.
        for (int j = 1; j < C; j++) {
            int countOnes = 0;
            for (int i = 0; i < R; i++) {
                if (grid[i][j] == 1) {
                    countOnes++;
                }
            }

            // Determine the number of 1s after a potential column flip.
            // If the number of zeros (R - countOnes) is greater than the number of ones (countOnes),
            // flipping the column will result in more ones.
            // So, we choose the maximum between current ones and (R - current ones).
            int effectiveOnes = Math.max(countOnes, R - countOnes);

            // Add the contribution of this column to the total score.
            // The weight of this column is 2^(C-1-j).
            score += effectiveOnes * (1 << (C - 1 - j));
        }

        return score;
    }
}