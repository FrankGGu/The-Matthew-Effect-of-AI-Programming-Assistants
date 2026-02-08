import java.util.*;

class Solution {
    private static final int[][] dirs = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    public int minCost(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] dp = new int[m][n];
        for (int[] row : dp) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        dp[0][0] = 0;
        Deque<int[]> deque = new ArrayDeque<>();
        deque.offer(new int[]{0, 0});
        while (!deque.isEmpty()) {
            int[] curr = deque.poll();
            int x = curr[0], y = curr[1];
            for (int i = 0; i < 4; i++) {
                int[] dir = dirs[i];
                int nx = x + dir[0], ny = y + dir[1];
                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    int cost = dp[x][y] + (grid[x][y] == i + 1 ? 0 : 1);
                    if (cost < dp[nx][ny]) {
                        dp[nx][ny] = cost;
                        if (grid[x][y] == i + 1) {
                            deque.offerFirst(new int[]{nx, ny});
                        } else {
                            deque.offerLast(new int[]{nx, ny});
                        }
                    }
                }
            }
        }
        return dp[m - 1][n - 1];
    }
}