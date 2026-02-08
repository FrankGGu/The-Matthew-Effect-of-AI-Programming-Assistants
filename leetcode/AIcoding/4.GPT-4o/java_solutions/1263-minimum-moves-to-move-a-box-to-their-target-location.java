import java.util.LinkedList;
import java.util.Queue;

public class Solution {
    public int minPushBox(char[][] grid) {
        int m = grid.length, n = grid[0].length;
        int[] box = new int[2], target = new int[2], player = new int[2];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 'B') {
                    box[0] = i; box[1] = j;
                } else if (grid[i][j] == 'T') {
                    target[0] = i; target[1] = j;
                } else if (grid[i][j] == 'S') {
                    player[0] = i; player[1] = j;
                }
            }
        }

        int[][] dirs = {{0,1}, {1,0}, {0,-1}, {-1,0}};
        boolean[][][][] visited = new boolean[m][n][m][n];
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{player[0], player[1], box[0], box[1], 0});
        visited[player[0]][player[1]][box[0]][box[1]] = true;

        while (!queue.isEmpty()) {
            int[] state = queue.poll();
            int px = state[0], py = state[1], bx = state[2], by = state[3], moves = state[4];

            if (bx == target[0] && by == target[1]) return moves;

            for (int[] dir : dirs) {
                int nbx = bx + dir[0], nby = by + dir[1];
                int npx = bx - dir[0], npy = by - dir[1];

                if (nbx >= 0 && nbx < m && nby >= 0 && nby < n && grid[nbx][nby] != '#' &&
                    npx >= 0 && npx < m && npy >= 0 && npy < n && grid[npx][npy] != '#' &&
                    !visited[nbx][nby][bx][by]) {
                    visited[nbx][nby][bx][by] = true;
                    queue.offer(new int[]{bx, by, nbx, nby, moves + 1});
                }
            }
        }
        return -1;
    }
}