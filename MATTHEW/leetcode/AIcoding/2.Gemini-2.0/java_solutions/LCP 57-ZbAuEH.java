class Solution {
    public int maxKilledEnemies(char[][] grid) {
        if (grid == null || grid.length == 0 || grid[0].length == 0) {
            return 0;
        }

        int rows = grid.length;
        int cols = grid[0].length;
        int maxEnemies = 0;

        int[][] left = new int[rows][cols];
        int[][] right = new int[rows][cols];
        int[][] up = new int[rows][cols];
        int[][] down = new int[rows][cols];

        for (int i = 0; i < rows; i++) {
            int count = 0;
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 'W') {
                    count = 0;
                } else if (grid[i][j] == 'E') {
                    count++;
                }
                left[i][j] = count;
            }

            count = 0;
            for (int j = cols - 1; j >= 0; j--) {
                if (grid[i][j] == 'W') {
                    count = 0;
                } else if (grid[i][j] == 'E') {
                    count++;
                }
                right[i][j] = count;
            }
        }

        for (int j = 0; j < cols; j++) {
            int count = 0;
            for (int i = 0; i < rows; i++) {
                if (grid[i][j] == 'W') {
                    count = 0;
                } else if (grid[i][j] == 'E') {
                    count++;
                }
                up[i][j] = count;
            }

            count = 0;
            for (int i = rows - 1; i >= 0; i--) {
                if (grid[i][j] == 'W') {
                    count = 0;
                } else if (grid[i][j] == 'E') {
                    count++;
                }
                down[i][j] = count;
            }
        }

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == '0') {
                    maxEnemies = Math.max(maxEnemies, left[i][j] + right[i][j] + up[i][j] + down[i][j]);
                }
            }
        }

        return maxEnemies;
    }
}