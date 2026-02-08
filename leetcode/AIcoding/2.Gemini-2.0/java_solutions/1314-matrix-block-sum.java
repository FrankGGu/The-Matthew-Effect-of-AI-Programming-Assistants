class Solution {
    public int[][] matrixBlockSum(int[][] mat, int k) {
        int m = mat.length;
        int n = mat[0].length;
        int[][] prefixSum = new int[m + 1][n + 1];

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                prefixSum[i][j] = prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1] + mat[i - 1][j - 1];
            }
        }

        int[][] result = new int[m][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int rowStart = Math.max(0, i - k);
                int rowEnd = Math.min(m - 1, i + k);
                int colStart = Math.max(0, j - k);
                int colEnd = Math.min(n - 1, j + k);

                result[i][j] = prefixSum[rowEnd + 1][colEnd + 1] - prefixSum[rowStart][colEnd + 1] - prefixSum[rowEnd + 1][colStart] + prefixSum[rowStart][colStart];
            }
        }

        return result;
    }
}