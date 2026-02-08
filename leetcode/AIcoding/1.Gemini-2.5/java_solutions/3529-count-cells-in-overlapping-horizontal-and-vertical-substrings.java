class Solution {
    public int countCells(String[] grid, int k) {
        int rows = grid.length;
        int cols = grid[0].length();

        int[][] left = new int[rows][cols];
        int[][] right = new int[rows][cols];
        int[][] up = new int[rows][cols];
        int[][] down = new int[rows][cols];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i].charAt(j) == '1') {
                    left[i][j] = (j > 0 ? left[i][j - 1] : 0) + 1;
                    up[i][j] = (i > 0 ? up[i - 1][j] : 0) + 1;
                }
            }
        }

        for (int i = rows - 1; i >= 0; i--) {
            for (int j = cols - 1; j >= 0; j--) {
                if (grid[i].charAt(j) == '1') {
                    right[i][j] = (j < cols - 1 ? right[i][j + 1] : 0) + 1;
                    down[i][j] = (i < rows - 1 ? down[i + 1][j] : 0) + 1;
                }
            }
        }

        int count = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i].charAt(j) == '1') {
                    int currentHorizontalLen = left[i][j] + right[i][j] - 1;
                    int currentVerticalLen = up[i][j] + down[i][j] - 1;

                    if (currentHorizontalLen >= k && currentVerticalLen >= k) {
                        count++;
                    }
                }
            }
        }

        return count;
    }
}