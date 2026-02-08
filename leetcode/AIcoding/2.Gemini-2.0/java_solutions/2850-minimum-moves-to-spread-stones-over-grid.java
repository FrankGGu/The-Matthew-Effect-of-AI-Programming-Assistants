import java.util.ArrayList;
import java.util.List;

class Solution {
    public int minimumMoves(int[][] grid) {
        List<int[]> zeros = new ArrayList<>();
        List<int[]> stones = new ArrayList<>();

        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[0].length; j++) {
                if (grid[i][j] == 0) {
                    zeros.add(new int[]{i, j});
                } else if (grid[i][j] > 1) {
                    for (int k = 0; k < grid[i][j] - 1; k++) {
                        stones.add(new int[]{i, j});
                    }
                }
            }
        }

        int n = zeros.size();
        int m = stones.size();

        if (n == 0 && m == 0) return 0;

        int[][] dp = new int[1 << n][m + 1];
        for (int i = 0; i < (1 << n); i++) {
            for (int j = 0; j <= m; j++) {
                dp[i][j] = Integer.MAX_VALUE;
            }
        }

        dp[0][0] = 0;

        for (int mask = 0; mask < (1 << n); mask++) {
            for (int stonesUsed = 0; stonesUsed <= m; stonesUsed++) {
                if (dp[mask][stonesUsed] == Integer.MAX_VALUE) continue;

                if (stonesUsed < m) {
                    for (int i = 0; i < n; i++) {
                        if ((mask & (1 << i)) == 0) {
                            int newMask = mask | (1 << i);
                            int cost = Math.abs(zeros.get(i)[0] - stones.get(stonesUsed)[0]) + Math.abs(zeros.get(i)[1] - stones.get(stonesUsed)[1]);
                            dp[newMask][stonesUsed + 1] = Math.min(dp[newMask][stonesUsed + 1], dp[mask][stonesUsed] + cost);
                        }
                    }
                }
            }
        }

        return dp[(1 << n) - 1][m];
    }
}