class Solution {
    public int minimumOperations(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        int minOperations = m * n; // Maximum possible operations

        // Iterate through all possible distinct pairs of values (v1, v2)
        // v1 will be the target value for cells where (i+j) is even
        // v2 will be the target value for cells where (i+j) is odd
        for (int v1 = 0; v1 <= 9; v1++) {
            for (int v2 = 0; v2 <= 9; v2++) {
                if (v1 == v2) {
                    continue; // The two values must be distinct to satisfy conditions
                }

                int currentOperations = 0;
                for (int i = 0; i < m; i++) {
                    for (int j = 0; j < n; j++) {
                        if ((i + j) % 2 == 0) { // Cells with an even sum (i+j)
                            if (grid[i][j] != v1) {
                                currentOperations++;
                            }
                        } else { // Cells with an odd sum (i+j)
                            if (grid[i][j] != v2) {
                                currentOperations++;
                            }
                        }
                    }
                }
                minOperations = Math.min(minOperations, currentOperations);
            }
        }

        return minOperations;
    }
}