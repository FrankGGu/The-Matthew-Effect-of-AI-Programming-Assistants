class Solution {
    public int[][] rangeAddQueries(int n, int[][] queries) {
        int[][] diff = new int[n][n];

        for (int[] query : queries) {
            int r1 = query[0];
            int c1 = query[1];
            int r2 = query[2];
            int c2 = query[3];

            diff[r1][c1]++;

            if (c2 + 1 < n) {
                diff[r1][c2 + 1]--;
            }
            if (r2 + 1 < n) {
                diff[r2 + 1][c1]--;
            }
            if (c2 + 1 < n && r2 + 1 < n) {
                diff[r2 + 1][c2 + 1]++;
            }
        }

        int[][] result = new int[n][n];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                result[i][j] = diff[i][j];
                if (i > 0) {
                    result[i][j] += result[i - 1][j];
                }
                if (j > 0) {
                    result[i][j] += result[i][j - 1];
                }
                if (i > 0 && j > 0) {
                    result[i][j] -= result[i - 1][j - 1];
                }
            }
        }

        return result;
    }
}