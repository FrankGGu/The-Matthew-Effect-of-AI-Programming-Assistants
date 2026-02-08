class Solution {
    public int largest1BorderedSquare(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] top = new int[m][n];
        int[][] left = new int[m][n];
        int maxSize = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    top[i][j] = (i == 0) ? 1 : top[i - 1][j] + 1;
                    left[i][j] = (j == 0) ? 1 : left[i][j - 1] + 1;
                    int size = Math.min(top[i][j], left[i][j]);
                    while (size > maxSize) {
                        if (top[i][j - size + 1] >= size && left[i - size + 1][j] >= size) {
                            maxSize = size;
                        }
                        size--;
                    }
                }
            }
        }
        return maxSize * maxSize;
    }
}