class Solution {
    public int maxSideLength(int[][] mat, int threshold) {
        int m = mat.length;
        int n = mat[0].length;
        int[][] prefixSum = new int[m + 1][n + 1];
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                prefixSum[i][j] = prefixSum[i - 1][j] + prefixSum[i][j - 1] - prefixSum[i - 1][j - 1] + mat[i - 1][j - 1];
            }
        }

        int maxLen = 0;
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                for (int k = maxLen + 1; i + k - 1 <= m && j + k - 1 <= n; k++) {
                    int sum = prefixSum[i + k - 1][j + k - 1] - prefixSum[i - 1][j + k - 1] - prefixSum[i + k - 1][j - 1] + prefixSum[i - 1][j - 1];
                    if (sum <= threshold) {
                        maxLen = k;
                    } else {
                        break;
                    }
                }
            }
        }

        return maxLen;
    }
}