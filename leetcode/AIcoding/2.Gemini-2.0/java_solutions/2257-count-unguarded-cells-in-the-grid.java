class Solution {
    public int countUnguarded(int m, int n, int[][] guards, int[][] walls) {
        int[][] grid = new int[m][n];

        for (int[] guard : guards) {
            grid[guard[0]][guard[1]] = 1; // 1 for guard
        }

        for (int[] wall : walls) {
            grid[wall[0]][wall[1]] = 2; // 2 for wall
        }

        for (int[] guard : guards) {
            int row = guard[0];
            int col = guard[1];

            // Move right
            for (int j = col + 1; j < n; j++) {
                if (grid[row][j] == 1 || grid[row][j] == 2) {
                    break;
                }
                grid[row][j] = -1; // -1 for guarded
            }

            // Move left
            for (int j = col - 1; j >= 0; j--) {
                if (grid[row][j] == 1 || grid[row][j] == 2) {
                    break;
                }
                grid[row][j] = -1;
            }

            // Move down
            for (int i = row + 1; i < m; i++) {
                if (grid[i][col] == 1 || grid[i][col] == 2) {
                    break;
                }
                grid[i][col] = -1;
            }

            // Move up
            for (int i = row - 1; i >= 0; i--) {
                if (grid[i][col] == 1 || grid[i][col] == 2) {
                    break;
                }
                grid[i][col] = -1;
            }
        }

        int unguardedCount = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 0) {
                    unguardedCount++;
                }
            }
        }

        return unguardedCount;
    }
}