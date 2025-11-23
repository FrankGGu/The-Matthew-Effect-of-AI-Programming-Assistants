class Solution {
    public int[][] buildMatrix(int k, int m, int n) {
        int[][] matrix = new int[m][n];
        int[] rowCount = new int[m];
        int[] colCount = new int[n];
        int num = 1;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (num > k) return new int[0][0];
                matrix[i][j] = num++;
                rowCount[i]++;
                colCount[j]++;
            }
        }

        for (int i = 0; i < m; i++) {
            if (rowCount[i] > k) return new int[0][0];
        }
        for (int j = 0; j < n; j++) {
            if (colCount[j] > k) return new int[0][0];
        }

        return matrix;
    }
}