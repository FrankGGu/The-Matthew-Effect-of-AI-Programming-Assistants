class Solution {
    public boolean checkXMatrix(int[][] grid) {
        int n = grid.length;
        for (int r = 0; r < n; r++) {
            for (int c = 0; c < n; c++) {
                boolean onDiagonal = (r == c) || (r + c == n - 1);
                if (onDiagonal) {
                    if (grid[r][c] == 0) {
                        return false;
                    }
                } else {
                    if (grid[r][c] != 0) {
                        return false;
                    }
                }
            }
        }
        return true;
    }
}