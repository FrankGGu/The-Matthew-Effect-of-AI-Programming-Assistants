class Solution {
    public int maxProductPath(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        long[][] maxDP = new long[m][n];
        long[][] minDP = new long[m][n];

        maxDP[0][0] = grid[0][0];
        minDP[0][0] = grid[0][0];

        for (int i = 1; i < m; i++) {
            maxDP[i][0] = maxDP[i - 1][0] * grid[i][0];
            minDP[i][0] = minDP[i - 1][0] * grid[i][0];
        }

        for (int j = 1; j < n; j++) {
            maxDP[0][j] = maxDP[0][j - 1] * grid[0][j];
            minDP[0][j] = minDP[0][j - 1] * grid[0][j];
        }

        for (int i = 1; i < m; i++) {
            for (int j = 1; j < n; j++) {
                long option1 = maxDP[i - 1][j] * grid[i][j];
                long option2 = minDP[i - 1][j] * grid[i][j];
                long option3 = maxDP[i][j - 1] * grid[i][j];
                long option4 = minDP[i][j - 1] * grid[i][j];

                maxDP[i][j] = Math.max(Math.max(option1, option2), Math.max(option3, option4));
                minDP[i][j] = Math.min(Math.min(option1, option2), Math.min(option3, option4));
            }
        }

        if (maxDP[m - 1][n - 1] < 0 && grid[0][0] != 0 && minDP[m - 1][n - 1] >= 0 && minDP[m - 1][n-1] == 0) return 0;
        if (maxDP[m - 1][n - 1] >= 0) {
            return (int) (maxDP[m - 1][n - 1] % 1000000007);
        } else if (grid[0][0] == 0) return 0;
        else if (maxDP[m - 1][n - 1] < 0 && minDP[m - 1][n - 1] == 0) return 0;
        else return (int) (maxDP[m - 1][n - 1] % 1000000007);

    }
}