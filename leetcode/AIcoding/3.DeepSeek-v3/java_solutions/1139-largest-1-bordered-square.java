class Solution {
    public int largest1BorderedSquare(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] left = new int[m][n];
        int[][] top = new int[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    left[i][j] = (j == 0) ? 1 : left[i][j - 1] + 1;
                    top[i][j] = (i == 0) ? 1 : top[i - 1][j] + 1;
                }
            }
        }

        int maxLen = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int len = Math.min(left[i][j], top[i][j]);
                while (len > maxLen) {
                    if (left[i - len + 1][j] >= len && top[i][j - len + 1] >= len) {
                        maxLen = len;
                        break;
                    }
                    len--;
                }
            }
        }

        return maxLen * maxLen;
    }
}