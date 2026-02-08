import java.util.*;

class Solution {
    public int[] kthNearestObstacle(int[][] grid, int[][] queries) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dist = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dist[i], -1);
        }

        Queue<int[]> queue = new LinkedList<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    queue.offer(new int[]{i, j, 0});
                    dist[i][j] = 0;
                }
            }
        }

        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int r = curr[0];
            int c = curr[1];
            int d = curr[2];

            for (int[] dir : directions) {
                int nr = r + dir[0];
                int nc = c + dir[1];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n && dist[nr][nc] == -1) {
                    dist[nr][nc] = d + 1;
                    queue.offer(new int[]{nr, nc, d + 1});
                }
            }
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int row = queries[i][0];
            int col = queries[i][1];
            int k = queries[i][2];

            PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> {
                if (a[0] != b[0]) {
                    return a[0] - b[0];
                } else {
                    if (grid[a[1]][a[2]] != grid[b[1]][b[2]]) {
                      return grid[b[1]][b[2]] - grid[a[1]][a[2]];
                    } else {
                      if (a[1] != b[1]) {
                        return a[1] - b[1];
                      } else {
                        return a[2] - b[2];
                      }
                    }
                }
            });

            for (int r = 0; r < m; r++) {
                for (int c = 0; c < n; c++) {
                    if (dist[r][c] != -1) {
                        int distance = Math.abs(r - row) + Math.abs(c - col);
                        pq.offer(new int[]{distance, r, c});
                    }
                }
            }

            if (pq.size() < k) {
                result[i] = -1;
            } else {
                int count = 0;
                int ansRow = -1;
                int ansCol = -1;
                while (!pq.isEmpty() && count < k) {
                    int[] curr = pq.poll();
                    ansRow = curr[1];
                    ansCol = curr[2];
                    count++;

                }
                result[i] = grid[ansRow][ansCol] == 1 ? dist[ansRow][ansCol] : -1;
                if (grid[ansRow][ansCol] != 1) result[i] = -1;
                int distance = Math.abs(ansRow - row) + Math.abs(ansCol - col);
                PriorityQueue<int[]> pq2 = new PriorityQueue<>((a,b) -> a[0] - b[0]);
                for (int r = 0; r < m; r++) {
                  for (int c = 0; c < n; c++) {
                    if (grid[r][c] == 1) {
                      pq2.offer(new int[]{Math.abs(r - row) + Math.abs(c - col), r, c});
                    }
                  }
                }
                int cnt = 0;
                int res = -1;
                while (!pq2.isEmpty()) {
                  int[] cur = pq2.poll();
                  cnt++;
                  if (cnt == k) {
                    res = cur[0];
                    break;
                  }
                }
                result[i] = res;
            }
        }

        return result;
    }
}