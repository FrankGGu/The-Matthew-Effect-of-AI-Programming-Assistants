class Solution {
    public int[][] constructProductMatrix(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int mod = 12345;

        int[][] prefix = new int[m][n];
        int[][] suffix = new int[m][n];
        int[][] answer = new int[m][n];

        long product = 1;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                prefix[i][j] = (int) product;
                product = (product * grid[i][j]) % mod;
            }
        }

        product = 1;
        for (int i = m - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                suffix[i][j] = (int) product;
                product = (product * grid[i][j]) % mod;
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                answer[i][j] = (prefix[i][j] * suffix[i][j]) % mod;
            }
        }

        return answer;
    }
}