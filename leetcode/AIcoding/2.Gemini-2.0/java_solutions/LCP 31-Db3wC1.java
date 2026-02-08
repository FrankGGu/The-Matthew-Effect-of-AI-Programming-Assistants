import java.util.*;

class Solution {
    public int solve(int[][] maze) {
        int n = maze.length;
        int m = maze[0].length;
        int[][] dist = new int[n][m];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dist[i], -1);
        }
        dist[0][0] = 0;
        Queue<int[]> q = new LinkedList<>();
        q.offer(new int[]{0, 0});
        int[] dx = {0, 0, 1, -1};
        int[] dy = {1, -1, 0, 0};

        while (!q.isEmpty()) {
            int[] curr = q.poll();
            int x = curr[0];
            int y = curr[1];
            int d = dist[x][y];

            for (int i = 0; i < 4; i++) {
                int nx = x + dx[i];
                int ny = y + dy[i];

                if (nx >= 0 && nx < n && ny >= 0 && ny < m && maze[nx][ny] == 0 && dist[nx][ny] == -1) {
                    dist[nx][ny] = d + 1;
                    q.offer(new int[]{nx, ny});
                }
            }

            for (int i = 0; i < 4; i++) {
                int nx = x + dx[i];
                int ny = y + dy[i];
                if (nx >= 0 && nx < n && ny >= 0 && ny < m && maze[nx][ny] == 1) {
                    for (int j = 0; j < n; j++) {
                        for (int k = 0; k < m; k++) {
                            if (maze[j][k] == 0 && dist[j][k] == -1) {
                                dist[j][k] = d + 1;
                                q.offer(new int[]{j, k});
                            }
                        }
                    }
                    Arrays.stream(maze).forEach(row -> Arrays.fill(row, 0));
                    break;
                }
            }
        }

        return dist[n - 1][m - 1];
    }
}