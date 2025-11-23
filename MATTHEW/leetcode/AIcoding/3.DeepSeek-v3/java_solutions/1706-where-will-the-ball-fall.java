class Solution {
    public int[] findBall(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[] res = new int[n];

        for (int i = 0; i < n; i++) {
            int row = 0;
            int col = i;
            while (row < m) {
                if (grid[row][col] == 1) {
                    if (col == n - 1 || grid[row][col + 1] == -1) {
                        res[i] = -1;
                        break;
                    }
                    col++;
                } else {
                    if (col == 0 || grid[row][col - 1] == 1) {
                        res[i] = -1;
                        break;
                    }
                    col--;
                }
                row++;
            }
            if (row == m) {
                res[i] = col;
            }
        }
        return res;
    }
}