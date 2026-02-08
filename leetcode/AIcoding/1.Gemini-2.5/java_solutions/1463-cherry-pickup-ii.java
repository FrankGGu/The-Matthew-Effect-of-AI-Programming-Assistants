import java.util.Arrays;

class Solution {
    public int cherryPickup(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;

        int[][][] dp = new int[rows][cols][cols];
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                Arrays.fill(dp[i][j], -1);
            }
        }

        dp[0][0][cols - 1] = grid[0][0] + grid[0][cols - 1];

        for (int r = 1; r < rows; r++) {
            for (int c1 = 0; c1 < cols; c1++) {
                for (int c2 = 0; c2 < cols; c2++) {
                    int currentCherries = grid[r][c1];
                    if (c1 != c2) {
                        currentCherries += grid[r][c2];
                    }

                    int maxPrevCherries = -1;

                    for (int prev_c1_offset = -1; prev_c1_offset <= 1; prev_c1_offset++) {
                        for (int prev_c2_offset = -1; prev_c2_offset <= 1; prev_c2_offset++) {
                            int prev_c1 = c1 + prev_c1_offset;
                            int prev_c2 = c2 + prev_c2_offset;

                            if (prev_c1 >= 0 && prev_c1 < cols && prev_c2 >= 0 && prev_c2 < cols) {
                                if (dp[r - 1][prev_c1][prev_c2] != -1) {
                                    maxPrevCherries = Math.max(maxPrevCherries, dp[r - 1][prev_c1][prev_c2]);
                                }
                            }
                        }
                    }

                    if (maxPrevCherries != -1) {
                        dp[r][c1][c2] = currentCherries + maxPrevCherries;
                    }
                }
            }
        }

        int maxTotalCherries = 0;
        for (int c1 = 0; c1 < cols; c1++) {
            for (int c2 = 0; c2 < cols; c2++) {
                maxTotalCherries = Math.max(maxTotalCherries, dp[rows - 1][c1][c2]);
            }
        }

        return maxTotalCherries;
    }
}