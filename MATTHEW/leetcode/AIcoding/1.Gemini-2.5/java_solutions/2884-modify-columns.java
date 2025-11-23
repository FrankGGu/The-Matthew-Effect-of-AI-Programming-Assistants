class Solution {
    public void modifyColumns(int[][] matrix) {
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return;
        }

        int R = matrix.length;
        int C = matrix[0].length;

        boolean[] colHasZero = new boolean[C];

        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                if (matrix[i][j] == 0) {
                    colHasZero[j] = true;
                }
            }
        }

        for (int j = 0; j < C; j++) {
            if (colHasZero[j]) {
                for (int i = 0; i < R; i++) {
                    matrix[i][j] = 0;
                }
            }
        }
    }
}