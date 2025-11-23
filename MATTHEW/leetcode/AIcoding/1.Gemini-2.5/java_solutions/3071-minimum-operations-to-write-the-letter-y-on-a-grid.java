class Solution {
    public int minimumOperations(int[][] grid) {
        int n = grid.length;
        int[] countY = new int[3];
        int[] countOther = new int[3];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                boolean isY = false;

                // Vertical stem of Y
                if (j == n / 2 && i >= n / 2) {
                    isY = true;
                }
                // Top-left arm of Y
                if (i == j && i < n / 2) {
                    isY = true;
                }
                // Top-right arm of Y
                if (i + j == n - 1 && i < n / 2) {
                    isY = true;
                }

                if (isY) {
                    countY[grid[i][j]]++;
                } else {
                    countOther[grid[i][j]]++;
                }
            }
        }

        int minOperations = Integer.MAX_VALUE;

        for (int yVal = 0; yVal < 3; yVal++) {
            for (int otherVal = 0; otherVal < 3; otherVal++) {
                if (yVal == otherVal) {
                    continue;
                }

                int currentOperations = 0;
                // Operations for Y cells
                for (int v = 0; v < 3; v++) {
                    if (v != yVal) {
                        currentOperations += countY[v];
                    }
                }
                // Operations for non-Y cells
                for (int v = 0; v < 3; v++) {
                    if (v != otherVal) {
                        currentOperations += countOther[v];
                    }
                }
                minOperations = Math.min(minOperations, currentOperations);
            }
        }

        return minOperations;
    }
}