class Solution {
    public int largest1BorderedSquare(int[][] grid) {
        if (grid == null || grid.length == 0 || grid[0].length == 0) {
            return 0;
        }

        int R = grid.length;
        int C = grid[0].length;

        int[][] left = new int[R][C];
        int[][] up = new int[R][C];

        for (int r = 0; r < R; r++) {
            for (int c = 0; c < C; c++) {
                if (grid[r][c] == 1) {
                    left[r][c] = (c > 0 ? left[r][c - 1] : 0) + 1;
                    up[r][c] = (r > 0 ? up[r - 1][c] : 0) + 1;
                } else {
                    left[r][c] = 0;
                    up[r][c] = 0;
                }
            }
        }

        int maxSide = 0;

        for (int r = 0; r < R; r++) {
            for (int c = 0; c < C; c++) {
                // 'k' represents the side length of the square
                // (r, c) is the bottom-right corner of the potential square
                // We iterate 'k' downwards from the maximum possible side length
                // which is limited by the current 'left' and 'up' counts at (r,c)
                for (int k = Math.min(left[r][c], up[r][c]); k >= 1; k--) {
                    // Check if the top side of length 'k' exists
                    // The top-right corner is (r - k + 1, c)
                    // We need to check if 'left' count at (r - k + 1, c) is at least 'k'
                    // Check if the left side of length 'k' exists
                    // The bottom-left corner is (r, c - k + 1)
                    // We need to check if 'up' count at (r, c - k + 1) is at least 'k'
                    if (left[r - k + 1][c] >= k && up[r][c - k + 1] >= k) {
                        maxSide = Math.max(maxSide, k);
                        break; // Found the largest square ending at (r,c), no need to check smaller k
                    }
                }
            }
        }

        return maxSide * maxSide;
    }
}