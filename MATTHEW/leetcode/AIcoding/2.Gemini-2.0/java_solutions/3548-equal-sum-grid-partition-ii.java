class Solution {
    public int maxArea(int n, int m, int[][] grid) {
        long totalSum = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                totalSum += grid[i][j];
            }
        }

        if (totalSum % 2 != 0) {
            return 0;
        }

        long targetSum = totalSum / 2;
        int maxArea = 0;

        for (int r1 = 0; r1 < n; r1++) {
            for (int c1 = 0; c1 < m; c1++) {
                for (int r2 = r1; r2 < n; r2++) {
                    for (int c2 = c1; c2 < m; c2++) {
                        long currentSum = 0;
                        for (int i = r1; i <= r2; i++) {
                            for (int j = c1; j <= c2; j++) {
                                currentSum += grid[i][j];
                            }
                        }

                        if (currentSum == targetSum) {
                            maxArea = Math.max(maxArea, (r2 - r1 + 1) * (c2 - c1 + 1));
                        }
                    }
                }
            }
        }

        return maxArea;
    }
}