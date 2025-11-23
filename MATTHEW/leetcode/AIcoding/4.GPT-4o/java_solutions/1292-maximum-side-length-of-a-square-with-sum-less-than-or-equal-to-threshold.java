class Solution {
    public int maxSideLength(int[][] mat, int threshold) {
        int m = mat.length, n = mat[0].length;
        int[][] prefixSum = new int[m + 1][n + 1];

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                prefixSum[i][j] = mat[i - 1][j - 1] + prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1];
            }
        }

        int maxLength = 0;
        for (int length = 1; length <= Math.min(m, n); length++) {
            for (int i = length; i <= m; i++) {
                for (int j = length; j <= n; j++) {
                    int sum = prefixSum[i][j] - prefixSum[i - length][j] - prefixSum[i][j - length] + prefixSum[i - length][j - length];
                    if (sum <= threshold) {
                        maxLength = length;
                    }
                }
            }
        }

        return maxLength;
    }
}