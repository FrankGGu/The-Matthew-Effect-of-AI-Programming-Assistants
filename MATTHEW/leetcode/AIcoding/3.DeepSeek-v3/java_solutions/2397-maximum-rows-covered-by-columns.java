class Solution {
    public int maximumRows(int[][] mat, int cols) {
        int m = mat.length;
        int n = mat[0].length;
        int maxRows = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            if (Integer.bitCount(mask) != cols) {
                continue;
            }

            int covered = 0;
            for (int i = 0; i < m; i++) {
                boolean isCovered = true;
                for (int j = 0; j < n; j++) {
                    if (mat[i][j] == 1 && (mask & (1 << j)) == 0) ) {
                        isCovered = false;
                        break;
                    }
                }
                if (isCovered) {
                    covered++;
                }
            }
            maxRows = Math.max(maxRows, covered);
        }

        return maxRows;
    }
}