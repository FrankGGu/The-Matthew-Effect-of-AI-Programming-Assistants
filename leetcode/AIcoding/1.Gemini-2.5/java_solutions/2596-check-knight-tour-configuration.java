class Solution {
    public boolean checkValidGrid(int[][] grid) {
        int n = grid.length;
        if (grid[0][0] != 0) {
            return false;
        }

        int[][] positions = new int[n * n][2];
        for (int r = 0; r < n; r++) {
            for (int c = 0; c < n; c++) {
                positions[grid[r][c]][0] = r;
                positions[grid[r][c]][1] = c;
            }
        }

        for (int k = 0; k < n * n - 1; k++) {
            int r1 = positions[k][0];
            int c1 = positions[k][1];
            int r2 = positions[k + 1][0];
            int c2 = positions[k + 1][1];

            int dr = Math.abs(r1 - r2);
            int dc = Math.abs(c1 - c2);

            if (!((dr == 1 && dc == 2) || (dr == 2 && dc == 1))) {
                return false;
            }
        }

        return true;
    }
}