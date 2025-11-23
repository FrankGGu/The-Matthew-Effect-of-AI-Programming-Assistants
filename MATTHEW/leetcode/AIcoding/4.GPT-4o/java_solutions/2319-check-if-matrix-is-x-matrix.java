class Solution {
    public boolean checkXMatrix(int[][] grid) {
        int n = grid.length;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if ((i + j == n - 1 || i == j) && grid[i][j] == 0) {
                    return false;
                }
                if (i + j != n - 1 && i != j && grid[i][j] != 0) {
                    return false;
                }
            }
        }
        return true;
    }
}