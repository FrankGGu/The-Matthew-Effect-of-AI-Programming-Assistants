public class Solution {
    public int orderOfLargestPlusSign(int n, int[][] mines) {
        int[][] grid = new int[n][n];
        for (int[] row : grid) {
            Arrays.fill(row, 1);
        }
        for (int[] mine : mines) {
            grid[mine[0]][mine[1]] = 0;
        }

        int[][] left = new int[n][n];
        int[][] right = new int[n][n];
        int[][] up = new int[n][n];
        int[][] down = new int[n][n];

        for (int i = 0; i < n; i++) {
            left[i][0] = grid[i][0];
            right[i][n - 1] = grid[i][n - 1];
            up[0][i] = grid[0][i];
            down[n - 1][i] = grid[n - 1][i];
        }

        for (int i = 0; i < n; i++) {
            for (int j = 1; j < n; j++) {
                left[i][j] = grid[i][j] == 1 ? left[i][j - 1] + 1 : 0;
            }
            for (int j = n - 2; j >= 0; j--) {
                right[i][j] = grid[i][j] == 1 ? right[i][j + 1] + 1 : 0;
            }
        }

        for (int j = 0; j < n; j++) {
            for (int i = 1; i < n; i++) {
                up[i][j] = grid[i][j] == 1 ? up[i - 1][j] + 1 : 0;
            }
            for (int i = n - 2; i >= 0; i--) {
                down[i][j] = grid[i][j] == 1 ? down[i + 1][j] + 1 : 0;
            }
        }

        int max = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int sign = Math.min(Math.min(left[i][j], right[i][j]), Math.min(up[i][j], down[i][j]));
                max = Math.max(max, sign);
            }
        }

        return max;
    }
}