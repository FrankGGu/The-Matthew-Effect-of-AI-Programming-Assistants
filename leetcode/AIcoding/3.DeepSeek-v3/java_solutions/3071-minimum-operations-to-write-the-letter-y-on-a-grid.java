class Solution {
    public int minimumOperationsToWriteY(int[][] grid) {
        int n = grid.length;
        int[] yCount = new int[3];
        int[] nonYCount = new int[3];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                boolean isY = (i == j && i <= n / 2) || (i + j == n - 1 && i <= n / 2) || (j == n / 2 && i >= n / 2);
                if (isY) {
                    yCount[grid[i][j]]++;
                } else {
                    nonYCount[grid[i][j]]++;
                }
            }
        }

        int minOperations = Integer.MAX_VALUE;
        for (int yVal = 0; yVal < 3; yVal++) {
            for (int nonYVal = 0; nonYVal < 3; nonYVal++) {
                if (yVal == nonYVal) continue;
                int operations = 0;
                for (int k = 0; k < 3; k++) {
                    if (k != yVal) operations += yCount[k];
                    if (k != nonYVal) operations += nonYCount[k];
                }
                minOperations = Math.min(minOperations, operations);
            }
        }

        return minOperations;
    }
}