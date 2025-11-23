class Solution {
    public int minFallingPathSum(int[][] grid) {
        int n = grid.length;
        if (n == 1) return grid[0][0];

        int[] prevRow = grid[0].clone();

        for (int i = 1; i < n; i++) {
            int[] currRow = new int[n];
            int min1 = Integer.MAX_VALUE, min2 = Integer.MAX_VALUE;
            int min1Idx = -1;

            for (int j = 0; j < n; j++) {
                if (prevRow[j] < min1) {
                    min2 = min1;
                    min1 = prevRow[j];
                    min1Idx = j;
                } else if (prevRow[j] < min2) {
                    min2 = prevRow[j];
                }
            }

            for (int j = 0; j < n; j++) {
                if (j != min1Idx) {
                    currRow[j] = grid[i][j] + min1;
                } else {
                    currRow[j] = grid[i][j] + min2;
                }
            }

            prevRow = currRow;
        }

        int minSum = Integer.MAX_VALUE;
        for (int num : prevRow) {
            minSum = Math.min(minSum, num);
        }
        return minSum;
    }
}