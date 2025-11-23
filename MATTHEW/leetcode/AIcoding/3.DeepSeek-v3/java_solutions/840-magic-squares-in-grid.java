class Solution {
    public int numMagicSquaresInside(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int count = 0;

        for (int i = 0; i <= rows - 3; i++) {
            for (int j = 0; j <= cols - 3; j++) {
                if (isMagicSquare(grid, i, j)) {
                    count++;
                }
            }
        }

        return count;
    }

    private boolean isMagicSquare(int[][] grid, int x, int y) {
        boolean[] seen = new boolean[10];

        for (int i = x; i < x + 3; i++) {
            for (int j = y; j < y + 3; j++) {
                int num = grid[i][j];
                if (num < 1 || num > 9 || seen[num]) {
                    return false;
                }
                seen[num] = true;
            }
        }

        int sum = grid[x][y] + grid[x][y+1] + grid[x][y+2];

        for (int i = 1; i < 3; i++) {
            if (grid[x+i][y] + grid[x+i][y+1] + grid[x+i][y+2] != sum) {
                return false;
            }
        }

        for (int j = 0; j < 3; j++) {
            if (grid[x][y+j] + grid[x+1][y+j] + grid[x+2][y+j] != sum) {
                return false;
            }
        }

        if (grid[x][y] + grid[x+1][y+1] + grid[x+2][y+2] != sum) {
            return false;
        }

        if (grid[x][y+2] + grid[x+1][y+1] + grid[x+2][y] != sum) {
            return false;
        }

        return true;
    }
}