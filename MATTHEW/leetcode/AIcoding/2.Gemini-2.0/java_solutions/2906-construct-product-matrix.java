class Solution {
    public int[][] constructProductMatrix(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] result = new int[m][n];
        long mod = 12345;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                long product = 1;
                for (int row = 0; row < m; row++) {
                    for (int col = 0; col < n; col++) {
                        if (row != i || col != j) {
                            product = (product * grid[row][col]) % mod;
                        }
                    }
                }
                result[i][j] = (int) product;
            }
        }

        return result;
    }
}