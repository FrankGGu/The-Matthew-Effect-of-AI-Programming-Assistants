class Solution {
    public int largest1BorderedSquare(int[][] grid) {
        int n = grid.length;
        int m = grid[0].length;
        int[][] horizontal = new int[n][m];
        int[][] vertical = new int[n][m];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (grid[i][j] == 1) {
                    horizontal[i][j] = (j == 0) ? 1 : horizontal[i][j - 1] + 1;
                    vertical[i][j] = (i == 0) ? 1 : vertical[i - 1][j] + 1;
                }
            }
        }

        int maxSide = 0;
        for (int i = n - 1; i >= 0; i--) {
            for (int j = m - 1; j >= 0; j--) {
                int side = Math.min(horizontal[i][j], vertical[i][j]);
                while (side > maxSide) {
                    if (horizontal[i - side + 1][j] >= side && vertical[i][j - side + 1] >= side) {
                        maxSide = side;
                        break;
                    }
                    side--;
                }
            }
        }
        return maxSide * maxSide;
    }
}