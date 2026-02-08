#include <vector>
#include <algorithm> // For std::max

class Solution {
public:
    int matrixScore(std::vector<std::vector<int>>& grid) {
        int m = grid.size();
        int n = grid[0].size();

        // Step 1: Ensure the first bit of each row is 1.
        // If grid[i][0] is 0, flip the entire row i.
        for (int i = 0; i < m; ++i) {
            if (grid[i][0] == 0) {
                for (int j = 0; j < n; ++j) {
                    grid[i][j] = 1 - grid[i][j];
                }
            }
        }

        // Step 2: For each column from the second one, maximize the number of 1s.
        // If the number of 0s is greater than the number of 1s in a column, flip that column.
        // The first column is already guaranteed to have all 1s from Step 1.

        int totalScore = 0;

        // Calculate score for each column
        for (int j = 0; j < n; ++j) {
            int onesInCol = 0;
            for (int i = 0; i < m; ++i) {
                if (grid[i][j] == 1) {
                    onesInCol++;
                }
            }

            // Determine the number of 1s we want for this column.
            // It's either 'onesInCol' or 'm - onesInCol' (if we flip the column).
            // We choose the larger one to maximize the score.
            int effectiveOnes = std::max(onesInCol, m - onesInCol);

            // Add the contribution of this column to the total score.
            // The weight of the bit at column j is 2^(n-1-j).
            totalScore += effectiveOnes * (1 << (n - 1 - j));
        }

        return totalScore;
    }
};