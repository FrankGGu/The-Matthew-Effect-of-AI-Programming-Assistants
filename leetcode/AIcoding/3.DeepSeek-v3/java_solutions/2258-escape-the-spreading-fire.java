import java.util.*;

class Solution {
    private static final int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public int maximumMinutes(int[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[][] fireTime = new int[m][n];
        for (int[] row : fireTime) Arrays.fill(row, Integer.MAX_VALUE);
        Queue<int[]> q = new LinkedList<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    fireTime[i][j] = 0;
                    q.offer(new int[]{i, j});
                }
            }
        }
        while (!q.isEmpty()) {
            int[] curr = q.poll();
            for (int[] d : dirs) {
                int x = curr[0] + d[0], y = curr[1] + d[1];
                if (x >= 0 && x < m && y >= 0 && y < n && grid[x][y] == 0 && fireTime[x][y] == Integer.MAX_VALUE) {
                    fireTime[x][y] = fireTime[curr[0]][curr[1]] + 1;
                    q.offer(new int[]{x, y});
                }
            }
        }
        int left = 0, right = m * n, res = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canReach(grid, fireTime, mid)) {
                res = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return res == m * n ? (int)1e9 : res;
    }

    private boolean canReach(int[][] grid, int[][] fireTime, int wait) {
        int m = grid.length, n = grid[0].length;
        boolean[][] visited = new boolean[m][n];
        Queue<int[]> q = new LinkedList<>();
        q.offer(new int[]{0, 0, wait});
        visited[0][0] = true;
        while (!q.isEmpty()) {
            int[] curr = q.poll();
            int i = curr[0], j = curr[1], time = curr[2];
            if (i == m - 1 && j == n - 1) return true;
            for (int[] d : dirs) {
                int x = i + d[0], y = j + d[1];
                if (x >= 0 && x < m && y >= 0 && y < n && grid[x][y] == 0 && !visited[x][y]) {
                    int newTime = time + 1;
                    if (x == m - 1 && y == n - 1) {
                        if (newTime <= fireTime[x][y]) return true;
                    } else {
                        if (newTime < fireTime[x][y]) {
                            visited[x][y] = true;
                            q.offer(new int[]{x, y, newTime});
                        }
                    }
                }
            }
        }
        return false;
    }
}