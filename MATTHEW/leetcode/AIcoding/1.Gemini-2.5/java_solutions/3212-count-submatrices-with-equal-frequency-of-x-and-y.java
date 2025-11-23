class Solution {
    public int countSubmatrices(char[][] grid) {
        int R = grid.length;
        int C = grid[0].length;

        int[][] prefixX = new int[R + 1][C + 1];
        int[][] prefixY = new int[R + 1][C + 1];

        int ans = 0;

        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                prefixX[i + 1][j + 1] = prefixX[i][j + 1] + prefixX[i + 1][j] - prefixX[i][j];
                prefixY[i + 1][j + 1] = prefixY[i][j + 1] + prefixY[i + 1][j] - prefixY[i][j];

                if (grid[i][j] == 'X') {
                    prefixX[i + 1][j + 1]++;
                } else if (grid[i][j] == 'Y') {
                    prefixY[i + 1][j + 1]++;
                }

                int countX = prefixX[i + 1][j + 1];
                int countY = prefixY[i + 1][j + 1];

                if (countX == countY && countX > 0) {
                    ans++;
                }
            }
        }
        return ans;
    }
}