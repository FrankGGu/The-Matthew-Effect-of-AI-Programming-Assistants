class Solution {
    public int[][] onesMinusZeros(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[] rowOnes = new int[m], rowZeros = new int[m];
        int[] colOnes = new int[n], colZeros = new int[n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    rowOnes[i]++;
                    colOnes[j]++;
                } else {
                    rowZeros[i]++;
                    colZeros[j]++;
                }
            }
        }

        int[][] result = new int[m][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                result[i][j] = rowOnes[i] - rowZeros[i] + colOnes[j] - colZeros[j];
            }
        }

        return result;
    }
}