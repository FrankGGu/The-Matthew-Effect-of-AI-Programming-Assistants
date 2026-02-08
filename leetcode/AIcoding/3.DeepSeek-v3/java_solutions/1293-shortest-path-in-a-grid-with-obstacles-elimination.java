import java.util.*;

class Solution {
    public int shortestPath(int[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        boolean[][][] visited = new boolean[m][n][k + 1];
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0, 0});
        visited[0][0][0] = true;
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] curr = queue.poll();
                int x = curr[0];
                int y = curr[1];
                int currK = curr[2];

                if (x == m - 1 && y == n - 1) {
                    return steps;
                }

                for (int[] dir : dirs) {
                    int nx = x + dir[0];
                    int ny = y + dir[1];
                    if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                        int nextK = currK + grid[nx][ny];
                        if (nextK <= k && !visited[nx][ny][nextK]) {
                            visited[nx][ny][nextK] = true;
                            queue.offer(new int[]{nx, ny, nextK});
                        }
                    }
                }
            }
            steps++;
        }
        return -1;
    }
}