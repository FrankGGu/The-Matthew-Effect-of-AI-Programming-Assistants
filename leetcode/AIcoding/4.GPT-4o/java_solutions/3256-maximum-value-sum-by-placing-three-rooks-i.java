class Solution {
    public int maxValue(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int maxSum = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                for (int k = i; k < rows; k++) {
                    for (int l = j; l < cols; l++) {
                        int sum = grid[i][j];
                        if (k != i || l != j) sum += grid[k][l];
                        for (int m = 0; m < rows; m++) {
                            for (int n = 0; n < cols; n++) {
                                if ((m != i || n != j) && (m != k || n != l)) {
                                    sum += grid[m][n];
                                }
                            }
                        }
                        maxSum = Math.max(maxSum, sum);
                    }
                }
            }
        }
        return maxSum;
    }
}