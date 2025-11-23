class Solution {
    public boolean canCut(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int totalSum = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                totalSum += grid[i][j];
            }
        }

        for (int i = 0; i < m; i++) {
            int rowSum = 0;
            for (int j = 0; j < n; j++) {
                rowSum += grid[i][j];
            }
            if (rowSum != 0 && totalSum - rowSum != 0 && rowSum * 2 == totalSum) {
                return true;
            }
        }

        for (int j = 0; j < n; j++) {
            int colSum = 0;
            for (int i = 0; i < m; i++) {
                colSum += grid[i][j];
            }
            if (colSum != 0 && totalSum - colSum != 0 && colSum * 2 == totalSum) {
                return true;
            }
        }

        return false;
    }
}