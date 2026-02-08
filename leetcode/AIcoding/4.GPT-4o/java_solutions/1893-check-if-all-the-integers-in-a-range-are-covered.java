class Solution {
    public boolean rangeAdditionII(int[][] intervals, int m, int n) {
        int[][] grid = new int[m + 1][n + 1];

        for (int[] interval : intervals) {
            int rowStart = interval[0];
            int rowEnd = interval[2];
            int colStart = interval[1];
            int colEnd = interval[3];

            grid[rowStart][colStart]++;
            if (rowEnd + 1 <= m) grid[rowEnd + 1][colStart]--;
            if (colEnd + 1 <= n) grid[rowStart][colEnd + 1]--;
            if (rowEnd + 1 <= m && colEnd + 1 <= n) grid[rowEnd + 1][colEnd + 1]++;
        }

        for (int i = 0; i <= m; i++) {
            for (int j = 0; j <= n; j++) {
                if (i > 0) grid[i][j] += grid[i - 1][j];
                if (j > 0) grid[i][j] += grid[i][j - 1];
                if (i > 0 && j > 0) grid[i][j] -= grid[i - 1][j - 1];
            }
        }

        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                if (grid[i][j] == 0) return false;
            }
        }

        return true;
    }
}