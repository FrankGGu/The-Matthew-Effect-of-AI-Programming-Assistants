class Solution {
    public int maxSideLength(int[][] mat, int threshold) {
        int m = mat.length;
        int n = mat[0].length;

        int[][] P = new int[m + 1][n + 1];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                P[i + 1][j + 1] = mat[i][j] + P[i][j + 1] + P[i + 1][j] - P[i][j];
            }
        }

        int low = 0;
        int high = Math.min(m, n);
        int ans = 0;

        while (low <= high) {
            int k = low + (high - low) / 2;
            if (k == 0) { // Side length 0 always has sum 0, which is <= threshold.
                ans = Math.max(ans, k);
                low = k + 1;
                continue;
            }

            boolean found = false;
            for (int r = 0; r <= m - k; r++) {
                for (int c = 0; c <= n - k; c++) {
                    int sum = P[r + k][c + k] - P[r][c + k] - P[r + k][c] + P[r][c];
                    if (sum <= threshold) {
                        found = true;
                        break;
                    }
                }
                if (found) {
                    break;
                }
            }

            if (found) {
                ans = Math.max(ans, k);
                low = k + 1;
            } else {
                high = k - 1;
            }
        }

        return ans;
    }
}