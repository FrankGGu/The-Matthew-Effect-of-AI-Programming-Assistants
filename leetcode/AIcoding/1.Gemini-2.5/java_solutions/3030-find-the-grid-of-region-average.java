class Solution {
    public int[][] resultGrid(int[][] grid, int threshold) {
        int m = grid.length;
        int n = grid[0].length;

        int[][] resultGrid = new int[m][n];
        int[][] sumOfAverages = new int[m][n];
        int[][] countOfRegions = new int[m][n];

        for (int r = 0; r <= m - 3; r++) {
            for (int c = 0; c <= n - 3; c++) {
                if (isValidRegion(grid, r, c, threshold)) {
                    int currentRegionAverage = calculateRegionAverage(grid, r, c);
                    for (int i = r; i < r + 3; i++) {
                        for (int j = c; j < c + 3; j++) {
                            sumOfAverages[i][j] += currentRegionAverage;
                            countOfRegions[i][j]++;
                        }
                    }
                }
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (countOfRegions[i][j] > 0) {
                    resultGrid[i][j] = sumOfAverages[i][j] / countOfRegions[i][j];
                } else {
                    resultGrid[i][j] = grid[i][j];
                }
            }
        }

        return resultGrid;
    }

    private boolean isValidRegion(int[][] grid, int r, int c, int threshold) {
        for (int i = r; i < r + 3; i++) {
            for (int j = c; j < c + 2; j++) {
                if (Math.abs(grid[i][j] - grid[i][j + 1]) > threshold) {
                    return false;
                }
            }
        }

        for (int i = r; i < r + 2; i++) {
            for (int j = c; j < c + 3; j++) {
                if (Math.abs(grid[i][j] - grid[i + 1][j]) > threshold) {
                    return false;
                }
            }
        }

        return true;
    }

    private int calculateRegionAverage(int[][] grid, int r, int c) {
        int sum = 0;
        for (int i = r; i < r + 3; i++) {
            for (int j = c; j < c + 3; j++) {
                sum += grid[i][j];
            }
        }
        return sum / 9;
    }
}