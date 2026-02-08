class Solution {
    public int minimumFlips(int[][] grid) {
        int n = grid.length;
        int m = grid[0].length;
        int flips = 0;

        for (int r = 0; r < n; r++) {
            for (int c = 0; c < m; c++) {
                int symR = n - 1 - r;
                int symC = m - 1 - c;

                if (grid[r][c] != grid[symR][symC]) {
                    flips++;
                }
            }
        }

        return flips / 2;
    }
}