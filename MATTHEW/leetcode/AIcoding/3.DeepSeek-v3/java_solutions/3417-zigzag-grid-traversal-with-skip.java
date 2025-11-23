class Solution {
    public int[] zigzagTraversal(int[][] matrix, int skip) {
        if (matrix == null || matrix.length == 0 || matrix[0].length == 0) {
            return new int[0];
        }

        int m = matrix.length;
        int n = matrix[0].length;
        int[] result = new int[m * n];
        int index = 0;
        boolean up = true;
        int row = 0, col = 0;

        while (index < m * n) {
            if (row >= 0 && row < m && col >= 0 && col < n) {
                if (matrix[row][col] != skip) {
                    result[index++] = matrix[row][col];
                }
            }

            if (up) {
                row--;
                col++;
            } else {
                row++;
                col--;
            }

            if (row < 0 || col >= n) {
                up = false;
                if (col >= n) {
                    col = n - 1;
                    row += 2;
                } else {
                    row = 0;
                }
            } else if (col < 0 || row >= m) {
                up = true;
                if (row >= m) {
                    row = m - 1;
                    col += 2;
                } else {
                    col = 0;
                }
            }
        }

        if (index < result.length) {
            int[] trimmedResult = new int[index];
            System.arraycopy(result, 0, trimmedResult, 0, index);
            return trimmedResult;
        }

        return result;
    }
}