class Solution {
    public boolean equalSumGridPartition(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        long[][] ps = new long[m + 1][n + 1];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                ps[i + 1][j + 1] = grid[i][j] + ps[i][j + 1] + ps[i + 1][j] - ps[i][j];
            }
        }

        long totalSum = ps[m][n];
        if (totalSum % 3 != 0) {
            return false;
        }
        long targetSum = totalSum / 3;

        // Helper function to get sum of a rectangle (inclusive coordinates)
        // (r1, c1) to (r2, c2)
        java.util.function.Function<int[], Long> getRectSum = coords -> {
            int r1 = coords[0];
            int c1 = coords[1];
            int r2 = coords[2];
            int c2 = coords[3];
            return ps[r2 + 1][c2 + 1] - ps[r1][c2 + 1] - ps[r2 + 1][c1] + ps[r1][c1];
        };

        // Case 1: Two horizontal cuts
        // Iterate through all possible positions for the two horizontal cuts
        // r1 is the row *after* the first part (0 to r1-1)
        // r2 is the row *after* the second part (r1 to r2-1)
        // The third part is (r2 to m-1)
        // r1 can range from 1 to m-2 (first part must be non-empty, leaving at least 2 rows for the other two parts)
        // r2 can range from r1+1 to m-1 (second part must be non-empty, leaving at least 1 row for the third part)
        if (m >= 3) {
            for (int r1 = 1; r1 < m - 1; r1++) {
                for (int r2 = r1 + 1; r2 < m; r2++) {
                    long s1 = getRectSum.apply(new int[]{0, 0, r1 - 1, n - 1});
                    long s2 = getRectSum.apply(new int[]{r1, 0, r2 - 1, n - 1});
                    long s3 = getRectSum.apply(new int[]{r2, 0, m - 1, n - 1});

                    if (s1 == targetSum && s2 == targetSum && s3 == targetSum) {
                        return true;
                    }
                }
            }
        }

        // Case 2: Two vertical cuts
        // Iterate through all possible positions for the two vertical cuts
        // c1 is the column *after* the first part (0 to c1-1)
        // c2 is the column *after* the second part (c1 to c2-1)
        // The third part is (c2 to n-1)
        // c1 can range from 1 to n-2 (first part must be non-empty, leaving at least 2 cols for the other two parts)
        // c2 can range from c1+1 to n-1 (second part must be non-empty, leaving at least 1 col for the third part)
        if (n >= 3) {
            for (int c1 = 1; c1 < n - 1; c1++) {
                for (int c2 = c1 + 1; c2 < n; c2++) {
                    long s1 = getRectSum.apply(new int[]{0, 0, m - 1, c1 - 1});
                    long s2 = getRectSum.apply(new int[]{0, c1, m - 1, c2 - 1});
                    long s3 = getRectSum.apply(new int[]{0, c2, m - 1, n - 1});

                    if (s1 == targetSum && s2 == targetSum && s3 == targetSum) {
                        return true;
                    }
                }
            }
        }

        return false;
    }
}