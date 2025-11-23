import java.util.*;

class Solution {
    private static final int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    public int maximumSafenessFactor(List<List<Integer>> grid) {
        int n = grid.size();
        if (grid.get(0).get(0) == 1 || grid.get(n - 1).get(n - 1) == 1) {
            return 0;
        }

        int[][] dist = new int[n][n];
        Queue<int[]> q = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid.get(i).get(j) == 1) {
                    dist[i][j] = 0;
                    q.offer(new int[]{i, j});
                } else {
                    dist[i][j] = -1;
                }
            }
        }

        while (!q.isEmpty()) {
            int[] curr = q.poll();
            for (int[] dir : dirs) {
                int x = curr[0] + dir[0];
                int y = curr[1] + dir[1];
                if (x >= 0 && x < n && y >= 0 && y < n && dist[x][y] == -1) {
                    dist[x][y] = dist[curr[0]][curr[1]] + 1;
                    q.offer(new int[]{x, y});
                }
            }
        }

        int left = 0, right = 2 * n, res = 0;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canReach(dist, mid)) {
                res = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return res;
    }

    private boolean canReach(int[][] dist, int minDist) {
        int n = dist.length;
        if (dist[0][0] < minDist || dist[n - 1][n - 1] < minDist) {
            return false;
        }

        Queue<int[]> q = new LinkedList<>();
        boolean[][] visited = new boolean[n][n];
        q.offer(new int[]{0, 0});
        visited[0][0] = true;

        while (!q.isEmpty()) {
            int[] curr = q.poll();
            if (curr[0] == n - 1 && curr[1] == n - 1) {
                return true;
            }
            for (int[] dir : dirs) {
                int x = curr[0] + dir[0];
                int y = curr[1] + dir[1];
                if (x >= 0 && x < n && y >= 0 && y < n && !visited[x][y] && dist[x][y] >= minDist) {
                    visited[x][y] = true;
                    q.offer(new int[]{x, y});
                }
            }
        }
        return false;
    }
}