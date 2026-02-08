class Solution {
    public int guardCastle(char[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;

        // guarded[r][c] stores true if cell (r, c) is guarded, false otherwise.
        boolean[][] guarded = new boolean[m][n];
        int guardsCount = 0;

        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                // If there's a building at (r, c) and it's not yet guarded
                if (grid[r][c] == '1' && !guarded[r][c]) {
                    guardsCount++;

                    // Place a guard. To cover (r, c) and maximize coverage to the bottom-right,
                    // the guard's center (gr, gc) should be chosen such that its protected region's
                    // top-left corner is as close to (r, c) as possible, and its bottom-right corner
                    // is maximized.
                    // The guard's center (gr, gc) must satisfy:
                    // max(abs(r - gr), abs(c - gc)) <= k
                    // This means:
                    // r - k <= gr <= r + k
                    // c - k <= gc <= c + k
                    // To maximize the bottom-right extent of the protected region (gr+k, gc+k),
                    // we need to maximize gr and gc.
                    // So, we ideally choose gr = r + k and gc = c + k.
                    // However, the guard's center (gr, gc) must be within the grid boundaries [0, m-1] x [0, n-1].
                    // Thus, we clamp gr and gc to be within the grid.
                    // The largest possible gr that covers r is r+k, but it must also be <= m-1.
                    // The largest possible gc that covers c is c+k, but it must also be <= n-1.
                    int gr = Math.min(m - 1, r + k);
                    int gc = Math.min(n - 1, c + k);

                    // Calculate the actual protected region by this guard placed at (gr, gc)
                    // The region is [gr-k, gr+k] x [gc-k, gc+k], clamped to grid boundaries.
                    int startR = Math.max(0, gr - k);
                    int endR = Math.min(m - 1, gr + k);
                    int startC = Math.max(0, gc - k);
                    int endC = Math.min(n - 1, gc + k);

                    // Mark all cells in this protected region as guarded
                    for (int row = startR; row <= endR; row++) {
                        for (int col = startC; col <= endC; col++) {
                            guarded[row][col] = true;
                        }
                    }
                }
            }
        }
        return guardsCount;
    }
}