class Solution {
    public int largestMagicSquare(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;

        // Precompute prefix sums for rows
        // rSum[i][j] stores sum of grid[i][0]...grid[i][j-1]
        // rSum[i][j+1] = rSum[i][j] + grid[i][j]
        int[][] rSum = new int[rows][cols + 1];
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                rSum[i][j + 1] = rSum[i][j] + grid[i][j];
            }
        }

        // Precompute prefix sums for columns
        // cSum[i][j] stores sum of grid[0][j]...grid[i-1][j]
        // cSum[i+1][j] = cSum[i][j] + grid[i][j]
        int[][] cSum = new int[rows + 1][cols];
        for (int j = 0; j < cols; j++) {
            for (int i = 0; i < rows; i++) {
                cSum[i + 1][j] = cSum[i][j] + grid[i][j];
            }
        }

        // Precompute prefix sums for main diagonals (top-left to bottom-right)
        // d1Sum[i][j] stores sum of elements on main diagonal ending at (i, j)
        // i.e., sum of grid[x][y] where x-y = i-j, x <= i, y <= j
        // d1Sum[i][j] = grid[i][j] + d1Sum[i-1][j-1] (if i,j > 0)
        int[][] d1Sum = new int[rows][cols];
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                d1Sum[i][j] = grid[i][j];
                if (i > 0 && j > 0) {
                    d1Sum[i][j] += d1Sum[i - 1][j - 1];
                }
            }
        }

        // Precompute prefix sums for anti-diagonals (top-right to bottom-left)
        // d2Sum[i][j] stores sum of elements on anti-diagonal ending at (i, j)
        // i.e., sum of grid[x][y] where x+y = i+j, x <= i, y >= j
        // d2Sum[i][j] = grid[i][j] + d2Sum[i-1][j+1] (if i > 0, j < cols-1)
        int[][] d2Sum = new int[rows][cols];
        for (int i = 0; i < rows; i++) {
            for (int j = cols - 1; j >= 0; j--) { 
                d2Sum[i][j] = grid[i][j];
                if (i > 0 && j < cols - 1) {
                    d2Sum[i][j] += d2Sum[i - 1][j + 1];
                }
            }
        }

        // Iterate k from max possible size down to 2
        for (int k = Math.min(rows, cols); k >= 2; k--) {
            // Iterate over all possible top-left corners (r, c)
            for (int r = 0; r <= rows - k; r++) {
                for (int c = 0; c <= cols - k; c++) {
                    int r_end = r + k - 1;
                    int c_end = c + k - 1;

                    // Calculate magic sum from the first row of the subgrid
                    int magicSum = rSum[r][c_end + 1] - rSum[r][c];
                    boolean isMagic = true;

                    // Check all rows in the subgrid
                    for (int i = r; i <= r_end; i++) {
                        if (rSum[i][c_end + 1] - rSum[i][c] != magicSum) {
                            isMagic = false;
                            break;
                        }
                    }
                    if (!isMagic) continue;

                    // Check all columns in the subgrid
                    for (int j = c; j <= c_end; j++) {
                        if (cSum[r_end + 1][j] - cSum[r][j] != magicSum) {
                            isMagic = false;
                            break;
                        }
                    }
                    if (!isMagic) continue;

                    // Check main diagonal (from (r,c) to (r_end, c_end))
                    int currentD1Sum = d1Sum[r_end][c_end];
                    if (r > 0 && c > 0) { 
                        currentD1Sum -= d1Sum[r - 1][c - 1];
                    }
                    if (currentD1Sum != magicSum) {
                        isMagic = false;
                    }
                    if (!isMagic) continue;

                    // Check anti-diagonal (from (r, c_end) to (r_end, c))
                    int currentD2Sum = d2Sum[r_end][c];
                    if (r > 0 && c_end < cols - 1) { 
                        currentD2Sum -= d2Sum[r - 1][c_end + 1];
                    }
                    if (currentD2Sum != magicSum) {
                        isMagic = false;
                    }
                    if (!isMagic) continue;

                    // If all checks pass, we found the largest magic square
                    return k;
                }
            }
        }

        // If no magic square of size >= 2 is found, a 1x1 square is always magic
        return 1;
    }
}