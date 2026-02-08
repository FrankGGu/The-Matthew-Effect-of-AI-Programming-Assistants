public class Solution {

import java.util.*;

public class Solution {
    public int minimumMoves(int[][] grid) {
        int n = grid.length;
        int[][][] dist = new int[n][n][4];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                Arrays.fill(dist[i][j], -1);
            }
        }
        Queue<int[]> q = new LinkedList<>();
        q.add(new int[]{0, 0, 0});
        dist[0][0][0] = 0;
        int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        while (!q.isEmpty()) {
            int[] state = q.poll();
            int x = state[0], y = state[1], d = state[2];
            int curDist = dist[x][y][d];
            if (x == n - 1 && y == n - 1) {
                return curDist;
            }
            for (int i = 0; i < 4; i++) {
                int nx = x + dirs[i][0];
                int ny = y + dirs[i][1];
                if (nx >= 0 && ny >= 0 && nx < n && ny < n && dist[nx][ny][i] == -1) {
                    dist[nx][ny][i] = curDist + 1;
                    q.add(new int[]{nx, ny, i});
                }
            }
            if (d == 0 || d == 2) {
                int ox = x + (d == 0 ? 0 : 0);
                int oy = y + (d == 0 ? 1 : -1);
                if (oy >= 0 && oy < n && dist[x][oy][1 - d] == -1) {
                    dist[x][oy][1 - d] = curDist + 1;
                    q.add(new int[]{x, oy, 1 - d});
                }
            } else {
                int ox = x + (d == 1 ? 1 : -1);
                int oy = y + (d == 1 ? 0 : 0);
                if (ox >= 0 && ox < n && dist[ox][y][1 - d] == -1) {
                    dist[ox][y][1 - d] = curDist + 1;
                    q.add(new int[]{ox, y, 1 - d});
                }
            }
        }
        return -1;
    }
}
}