class Solution {
    public int countSubmatrices(int[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] sum = new int[m][n];
        int count = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                sum[i][j] = grid[i][j];
                if (i > 0) {
                    sum[i][j] += sum[i - 1][j];
                }
                if (j > 0) {
                    sum[i][j] += sum[i][j - 1];
                }
                if (i > 0 && j > 0) {
                    sum[i][j] -= sum[i - 1][j - 1];
                }

                if (sum[i][j] < k) {
                    count++;
                }
            }
        }

        return count;
    }
}