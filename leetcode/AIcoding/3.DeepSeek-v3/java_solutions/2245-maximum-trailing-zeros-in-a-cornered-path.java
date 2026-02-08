class Solution {
    public int maxTrailingZeros(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        int[][][] cnt2 = new int[m + 1][n + 1][2];
        int[][][] cnt5 = new int[m + 1][n + 1][2];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int num = grid[i][j];
                int two = 0, five = 0;
                while (num % 2 == 0) {
                    two++;
                    num /= 2;
                }
                while (num % 5 == 0) {
                    five++;
                    num /= 5;
                }
                cnt2[i + 1][j + 1][0] = cnt2[i][j + 1][0] + two;
                cnt2[i + 1][j + 1][1] = cnt2[i + 1][j][1] + two;
                cnt5[i + 1][j + 1][0] = cnt5[i][j + 1][0] + five;
                cnt5[i + 1][j + 1][1] = cnt5[i + 1][j][1] + five;
            }
        }

        int res = 0;
        for (int i = 1; i <= m; i++) {
            for (int j = 1; j <= n; j++) {
                int up2 = cnt2[i][j][0] - cnt2[0][j][0];
                int down2 = cnt2[m][j][0] - cnt2[i - 1][j][0];
                int left2 = cnt2[i][j][1] - cnt2[i][0][1];
                int right2 = cnt2[i][n][1] - cnt2[i][j - 1][1];

                int up5 = cnt5[i][j][0] - cnt5[0][j][0];
                int down5 = cnt5[m][j][0] - cnt5[i - 1][j][0];
                int left5 = cnt5[i][j][1] - cnt5[i][0][1];
                int right5 = cnt5[i][n][1] - cnt5[i][j - 1][1];

                res = Math.max(res, Math.min(up2 + left2 - twoCount(grid[i - 1][j - 1]), up5 + left5 - fiveCount(grid[i - 1][j - 1])));
                res = Math.max(res, Math.min(up2 + right2 - twoCount(grid[i - 1][j - 1]), up5 + right5 - fiveCount(grid[i - 1][j - 1])));
                res = Math.max(res, Math.min(down2 + left2 - twoCount(grid[i - 1][j - 1]), down5 + left5 - fiveCount(grid[i - 1][j - 1])));
                res = Math.max(res, Math.min(down2 + right2 - twoCount(grid[i - 1][j - 1]), down5 + right5 - fiveCount(grid[i - 1][j - 1])));
            }
        }
        return res;
    }

    private int twoCount(int num) {
        int count = 0;
        while (num % 2 == 0) {
            count++;
            num /= 2;
        }
        return count;
    }

    private int fiveCount(int num) {
        int count = 0;
        while (num % 5 == 0) {
            count++;
            num /= 5;
        }
        return count;
    }
}