class Solution {
    public int orderOfLargestPlusSign(int N, int[][] mines) {
        int[][] grid = new int[N][N];
        for (int[] mine : mines) {
            grid[mine[0]][mine[1]] = 1;
        }

        int[][] up = new int[N][N];
        int[][] down = new int[N][N];
        int[][] left = new int[N][N];
        int[][] right = new int[N][N];

        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                if (grid[i][j] == 0) {
                    up[i][j] = (i == 0 ? 0 : up[i - 1][j]) + 1;
                    left[i][j] = (j == 0 ? 0 : left[i][j - 1]) + 1;
                }
            }
        }

        for (int i = N - 1; i >= 0; i--) {
            for (int j = N - 1; j >= 0; j--) {
                if (grid[i][j] == 0) {
                    down[i][j] = (i == N - 1 ? 0 : down[i + 1][j]) + 1;
                    right[i][j] = (j == N - 1 ? 0 : right[i][j + 1]) + 1;
                }
            }
        }

        int maxOrder = 0;
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                if (grid[i][j] == 0) {
                    int order = Math.min(Math.min(up[i][j], down[i][j]), Math.min(left[i][j], right[i][j]));
                    maxOrder = Math.max(maxOrder, order);
                }
            }
        }

        return maxOrder;
    }
}