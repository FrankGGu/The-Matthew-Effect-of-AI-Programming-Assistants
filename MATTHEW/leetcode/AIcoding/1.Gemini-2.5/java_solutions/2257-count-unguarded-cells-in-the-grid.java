class Solution {
    public int countUnguarded(int m, int n, int[][] grid) {
        boolean[][] isGuarded = new boolean[m][n];

        // Scan rows
        for (int r = 0; r < m; r++) {
            // Left to right
            boolean hasGuard = false;
            for (int c = 0; c < n; c++) {
                if (grid[r][c] == 1) { // Wall
                    hasGuard = false;
                } else if (grid[r][c] == 2) { // Guard
                    hasGuard = true;
                } else { // Empty cell
                    if (hasGuard) {
                        isGuarded[r][c] = true;
                    }
                }
            }

            // Right to left
            hasGuard = false;
            for (int c = n - 1; c >= 0; c--) {
                if (grid[r][c] == 1) { // Wall
                    hasGuard = false;
                } else if (grid[r][c] == 2) { // Guard
                    hasGuard = true;
                } else { // Empty cell
                    if (hasGuard) {
                        isGuarded[r][c] = true;
                    }
                }
            }
        }

        // Scan columns
        for (int c = 0; c < n; c++) {
            // Top to bottom
            boolean hasGuard = false;
            for (int r = 0; r < m; r++) {
                if (grid[r][c] == 1) { // Wall
                    hasGuard = false;
                } else if (grid[r][c] == 2) { // Guard
                    hasGuard = true;
                } else { // Empty cell
                    if (hasGuard) {
                        isGuarded[r][c] = true;
                    }
                }
            }

            // Bottom to top
            hasGuard = false;
            for (int r = m - 1; r >= 0; r--) {
                if (grid[r][c] == 1) { // Wall
                    hasGuard = false;
                } else if (grid[r][c] == 2) { // Guard
                    hasGuard = true;
                } else { // Empty cell
                    if (hasGuard) {
                        isGuarded[r][c] = true;
                    }
                }
            }
        }

        int unguardedCount = 0;
        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                if (grid[r][c] == 0 && !isGuarded[r][c]) {
                    unguardedCount++;
                }
            }
        }

        return unguardedCount;
    }
}