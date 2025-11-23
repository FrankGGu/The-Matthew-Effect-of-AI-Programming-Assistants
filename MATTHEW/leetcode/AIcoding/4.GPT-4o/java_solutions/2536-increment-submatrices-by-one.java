class Solution {
    public int[][] incrementSubmatrices(int[][] mat, int[][] increments) {
        int m = mat.length, n = mat[0].length;
        int[][] result = new int[m][n];
        int[][] inc = new int[m + 1][n + 1];

        for (int[] incs : increments) {
            int x1 = incs[0], y1 = incs[1], x2 = incs[2], y2 = incs[3];
            inc[x1][y1]++;
            inc[x2 + 1][y2 + 1]++;
            inc[x1][y2 + 1]--;
            inc[x2 + 1][y1]--;
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                inc[i][j + 1] += inc[i][j];
            }
        }

        for (int j = 0; j < n; j++) {
            for (int i = 0; i < m; i++) {
                inc[i + 1][j] += inc[i][j];
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                result[i][j] = mat[i][j] + inc[i][j];
            }
        }

        return result;
    }
}