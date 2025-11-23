public class Solution {

import java.util.*;

public class Solution {
    public int minimumMoves(int[][] grid) {
        int n = grid.length;
        List<int[]> stones = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] > 1) {
                    for (int k = 1; k < grid[i][j]; k++) {
                        stones.add(new int[]{i, j});
                    }
                }
            }
        }
        int m = stones.size();
        int[][] dist = new int[m][m];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < m; j++) {
                dist[i][j] = Math.abs(stones.get(i)[0] - stones.get(j)[0]) + Math.abs(stones.get(i)[1] - stones.get(j)[1]);
            }
        }
        int[] dp = new int[1 << m];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;
        for (int mask = 0; mask < (1 << m); mask++) {
            int count = 0;
            for (int i = 0; i < m; i++) {
                if ((mask >> i) & 1) count++;
            }
            if (count % 2 == 1) continue;
            for (int i = 0; i < m; i++) {
                if ((mask >> i) & 1) {
                    for (int j = i + 1; j < m; j++) {
                        if ((mask >> j) & 1) {
                            int nextMask = mask ^ (1 << i) ^ (1 << j);
                            dp[nextMask] = Math.min(dp[nextMask], dp[mask] + dist[i][j]);
                        }
                    }
                }
            }
        }
        return dp[(1 << m) - 1];
    }
}
}