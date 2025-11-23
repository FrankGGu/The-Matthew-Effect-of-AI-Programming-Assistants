import java.util.Arrays;

class Solution {
    public int minTotalDistance(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[] x = new int[m * n];
        int index = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    x[index++] = i;
                }
            }
        }

        int medianX = x[index / 2];
        Arrays.sort(x, 0, index);
        int medianY = findMedianY(grid, index);

        return calculateDistance(x, medianX) + calculateDistance(grid, medianY);
    }

    private int findMedianY(int[][] grid, int count) {
        int[] y = new int[count];
        int index = 0;

        for (int j = 0; j < grid[0].length; j++) {
            for (int i = 0; i < grid.length; i++) {
                if (grid[i][j] == 1) {
                    y[index++] = j;
                }
            }
        }

        Arrays.sort(y, 0, count);
        return y[count / 2];
    }

    private int calculateDistance(int[] positions, int median) {
        int distance = 0;
        for (int pos : positions) {
            distance += Math.abs(pos - median);
        }
        return distance;
    }

    private int calculateDistance(int[][] grid, int medianY) {
        int distance = 0;
        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                if (grid[i][j] == 1) {
                    distance += Math.abs(j - medianY);
                }
            }
        }
        return distance;
    }
}