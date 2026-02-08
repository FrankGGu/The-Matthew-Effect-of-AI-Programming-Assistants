class Solution {
    public boolean checkGrid(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        // Condition 1: grid[i][j] is equal to grid[i+1][j] for all i from 0 to m-2 and all j from 0 to n-1.
        for (int i = 0; i < m - 1; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] != grid[i+1][j]) {
                    return false;
                }
            }
        }

        // Condition 2: grid[i][j] is not equal to grid[i][j+1] for all i from 0 to m-1 and all j from 0 to n-2.
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n - 1; j++) {
                if (grid[i][j] == grid[i][j+1]) {
                    return false;
                }
            }
        }

        return true;
    }
}