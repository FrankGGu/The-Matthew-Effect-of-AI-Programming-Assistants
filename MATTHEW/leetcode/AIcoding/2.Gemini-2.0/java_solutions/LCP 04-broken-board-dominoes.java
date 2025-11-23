class Solution {
    public int domino(int n, int m, int[] brokenRows, int[] brokenCols) {
        boolean[][] broken = new boolean[n][m];
        for (int row : brokenRows) {
            for (int col = 0; col < m; col++) {
                broken[row][col] = true;
            }
        }
        for (int col : brokenCols) {
            for (int row = 0; row < n; row++) {
                broken[row][col] = true;
            }
        }

        int count = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (!broken[i][j]) {
                    if (j + 1 < m && !broken[i][j + 1]) {
                        count++;
                        broken[i][j] = true;
                        broken[i][j + 1] = true;
                    } else if (i + 1 < n && !broken[i + 1][j]) {
                        count++;
                        broken[i][j] = true;
                        broken[i + 1][j] = true;
                    }
                }
            }
        }
        return count;
    }
}