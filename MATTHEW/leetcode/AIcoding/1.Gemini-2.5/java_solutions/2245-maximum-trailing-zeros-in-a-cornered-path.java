class Solution {
    public int maxTrailingZeros(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;

        int[][][] factors = new int[rows][cols][2]; // [r][c][0] for count of 2s, [r][c][1] for count of 5s

        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                int val = grid[r][c];
                int c2 = 0;
                while (val > 0 && val % 2 == 0) {
                    c2++;
                    val /= 2;
                }
                int c5 = 0;
                while (val > 0 && val % 5 == 0) {
                    c5++;
                    val /= 5;
                }
                factors[r][c][0] = c2;
                factors[r][c][1] = c5;
            }
        }

        int[][][] prefixRow = new int[rows][cols][2]; // sum of factors from (r,0) to (r,c)
        int[][][] prefixCol = new int[rows][cols][2]; // sum of factors from (0,c) to (r,c)
        int[][][] suffixRow = new int[rows][cols][2]; // sum of factors from (r,c) to (r,cols-1)
        int[][][] suffixCol = new int[rows][cols][2]; // sum of factors from (r,c) to (rows-1,c)

        // Populate prefixRow sums
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                prefixRow[r][c][0] = factors[r][c][0] + (c > 0 ? prefixRow[r][c-1][0] : 0);
                prefixRow[r][c][1] = factors[r][c][1] + (c > 0 ? prefixRow[r][c-1][1] : 0);
            }
        }

        // Populate prefixCol sums
        for (int c = 0; c < cols; c++) {
            for (int r = 0; r < rows; r++) {
                prefixCol[r][c][0] = factors[r][c][0] + (r > 0 ? prefixCol[r-1][c][0] : 0);
                prefixCol[r][c][1] = factors[r][c][1] + (r > 0 ? prefixCol[r-1][c][1] : 0);
            }
        }

        // Populate suffixRow sums
        for (int r = 0; r < rows; r++) {
            for (int c = cols - 1; c >= 0; c--) {
                suffixRow[r][c][0] = factors[r][c][0] + (c < cols - 1 ? suffixRow[r][c+1][0] : 0);
                suffixRow[r][c][1] = factors[r][c][1] + (c < cols - 1 ? suffixRow[r][c+1][1] : 0);
            }
        }

        // Populate suffixCol sums
        for (int c = 0; c < cols; c++) {
            for (int r = rows - 1; r >= 0; r--) {
                suffixCol[r][c][0] = factors[r][c][0] + (r < rows - 1 ? suffixCol[r+1][c][0] : 0);
                suffixCol[r][c][1] = factors[r][c][1] + (r < rows - 1 ? suffixCol[r+1][c][1] : 0);
            }
        }

        int maxZeros = 0;

        // Iterate through each cell as a potential corner
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                // Four types of cornered paths for each cell (r,c)

                // Path 1: Horizontal segment from (r,0) to (r,c) and Vertical segment from (0,c) to (r,c)
                // (Left arm + Up arm)
                int f2_1 = prefixRow[r][c][0] + prefixCol[r][c][0] - factors[r][c][0];
                int f5_1 = prefixRow[r][c][1] + prefixCol[r][c][1] - factors[r][c][1];
                maxZeros = Math.max(maxZeros, Math.min(f2_1, f5_1));

                // Path 2: Horizontal segment from (r,0) to (r,c) and Vertical segment from (r,c) to (rows-1,c)
                // (Left arm + Down arm)
                int f2_2 = prefixRow[r][c][0] + suffixCol[r][c][0] - factors[r][c][0];
                int f5_2 = prefixRow[r][c][1] + suffixCol[r][c][1] - factors[r][c][1];
                maxZeros = Math.max(maxZeros, Math.min(f2_2, f5_2));

                // Path 3: Horizontal segment from (r,c) to (r,cols-1) and Vertical segment from (0,c) to (r,c)
                // (Right arm + Up arm)
                int f2_3 = suffixRow[r][c][0] + prefixCol[r][c][0] - factors[r][c][0];
                int f5_3 = suffixRow[r][c][1] + prefixCol[r][c][1] - factors[r][c][1];
                maxZeros = Math.max(maxZeros, Math.min(f2_3, f5_3));

                // Path 4: Horizontal segment from (r,c) to (r,cols-1) and Vertical segment from (r,c) to (rows-1,c)
                // (Right arm + Down arm)
                int f2_4 = suffixRow[r][c][0] + suffixCol[r][c][0] - factors[r][c][0];
                int f5_4 = suffixRow[r][c][1] + suffixCol[r][c][1] - factors[r][c][1];
                maxZeros = Math.max(maxZeros, Math.min(f2_4, f5_4));
            }
        }

        return maxZeros;
    }
}