class Solution {
    public boolean checkValidGrid(int[][] grid) {
        if (grid[0][0] != 0) {
            return false;
        }
        int n = grid.length;
        int[][] moves = new int[n * n][2];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                moves[grid[i][j]][0] = i;
                moves[grid[i][j]][1] = j;
            }
        }
        for (int i = 1; i < n * n; i++) {
            int dx = Math.abs(moves[i][0] - moves[i - 1][0]);
            int dy = Math.abs(moves[i][1] - moves[i - 1][1]);
            if (!((dx == 1 && dy == 2) || (dx == 2 && dy == 1))) {
                return false;
            }
        }
        return true;
    }
}