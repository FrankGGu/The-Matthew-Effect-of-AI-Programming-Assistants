class Solution {
    public int maximumRows(int[][] matrix, int cols) {
        int m = matrix.length;
        int n = matrix[0].length;
        int maxRows = 0;

        for (int i = 0; i < (1 << n); i++) {
            if (Integer.bitCount(i) != cols) {
                continue;
            }

            int coveredRows = 0;
            for (int row = 0; row < m; row++) {
                boolean isCovered = true;
                for (int col = 0; col < n; col++) {
                    if (matrix[row][col] == 1 && (i & (1 << col)) == 0) {
                        isCovered = false;
                        break;
                    }
                }
                if (isCovered) {
                    coveredRows++;
                }
            }
            maxRows = Math.max(maxRows, coveredRows);
        }

        return maxRows;
    }
}