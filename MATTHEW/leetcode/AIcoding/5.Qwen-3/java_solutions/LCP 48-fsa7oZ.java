public class Solution {

import java.util.*;

public class Solution {
    public int[] chessGame(int[][] board) {
        int n = board.length;
        int m = board[0].length;
        int[][] dist = new int[n][m];
        boolean[][] visited = new boolean[n][m];
        Queue<int[]> queue = new LinkedList<>();

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (board[i][j] == 1) {
                    queue.add(new int[]{i, j});
                    visited[i][j] = true;
                }
            }
        }

        int[] directions = {-1, 0, 1, 0, -1};
        while (!queue.isEmpty()) {
            int[] cell = queue.poll();
            int x = cell[0], y = cell[1];
            for (int k = 0; k < 4; k++) {
                int nx = x + directions[k];
                int ny = y + directions[k + 1];
                if (nx >= 0 && nx < n && ny >= 0 && ny < m && !visited[nx][ny]) {
                    dist[nx][ny] = dist[x][y] + 1;
                    visited[nx][ny] = true;
                    queue.add(new int[]{nx, ny});
                }
            }
        }

        int maxDist = 0;
        int[] result = new int[2];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (board[i][j] == 0 && dist[i][j] > maxDist) {
                    maxDist = dist[i][j];
                    result[0] = i;
                    result[1] = j;
                }
            }
        }

        return result;
    }
}
}