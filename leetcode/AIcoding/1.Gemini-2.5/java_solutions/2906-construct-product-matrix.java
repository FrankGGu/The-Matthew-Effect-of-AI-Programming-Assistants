class Solution {
    public int[][] constructProductMatrix(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int N = rows * cols;
        int MOD = 12345;

        long[] prefixProducts = new long[N];
        long[] suffixProducts = new long[N];

        prefixProducts[0] = 1;
        for (int i = 1; i < N; i++) {
            int r_prev = (i - 1) / cols;
            int c_prev = (i - 1) % cols;
            prefixProducts[i] = (prefixProducts[i - 1] * grid[r_prev][c_prev]) % MOD;
        }

        suffixProducts[N - 1] = 1;
        for (int i = N - 2; i >= 0; i--) {
            int r_next = (i + 1) / cols;
            int c_next = (i + 1) % cols;
            suffixProducts[i] = (suffixProducts[i + 1] * grid[r_next][c_next]) % MOD;
        }

        int[][] productMatrix = new int[rows][cols];
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                int k = r * cols + c;
                productMatrix[r][c] = (int)((prefixProducts[k] * suffixProducts[k]) % MOD);
            }
        }

        return productMatrix;
    }
}