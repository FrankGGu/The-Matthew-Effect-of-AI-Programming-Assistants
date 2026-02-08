class Solution {
    public int orderOfLargestPlusSign(int n, int[][] mines) {
        int[][] grid = new int[n][n];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                grid[i][j] = 1;
            }
        }

        for (int[] mine : mines) {
            grid[mine[0]][mine[1]] = 0;
        }

        int[][] left = new int[n][n];
        int[][] right = new int[n][n];
        int[][] up = new int[n][n];
        int[][] down = new int[n][n];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    left[i][j] = (j == 0 ? 0 : left[i][j - 1]) + 1;
                    up[i][j] = (i == 0 ? 0 : up[i - 1][j]) + 1;
                }
            }
        }

        for (int i = n - 1; i >= 0; i--) {
            for (int j = n - 1; j >= 0; j--) {
                if (grid[i][j] == 1) {
                    right[i][j] = (j == n - 1 ? 0 : right[i][j + 1]) + 1;
                    down[i][j] = (i == n - 1 ? 0 : down[i + 1][j]) + 1;
                }
            }
        }

        int maxOrder = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    int currentOrder = Math.min(Math.min(left[i][j], right[i][j]), Math.min(up[i][j], down[i][j]));
                    maxOrder = Math.max(maxOrder, currentOrder);
                }
            }
        }

        return maxOrder;
    }
}