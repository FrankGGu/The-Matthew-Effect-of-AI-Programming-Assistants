import java.util.LinkedList;
import java.util.Queue;

public class Solution {
    public int shortestPath(int[][] grid, int k) {
        int m = grid.length, n = grid[0].length;
        if (m == 0 || n == 0) return -1;
        boolean[][][] visited = new boolean[m][n][k + 1];
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0, 0, 0}); // x, y, obstacles eliminated, distance
        visited[0][0][0] = true;

        int[][] directions = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}};

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int x = curr[0], y = curr[1], obstacles = curr[2], dist = curr[3];

            if (x == m - 1 && y == n - 1) return dist;

            for (int[] dir : directions) {
                int newX = x + dir[0], newY = y + dir[1];
                if (newX >= 0 && newX < m && newY >= 0 && newY < n) {
                    int newObstacles = obstacles + grid[newX][newY];
                    if (newObstacles <= k && !visited[newX][newY][newObstacles]) {
                        visited[newX][newY][newObstacles] = true;
                        queue.offer(new int[]{newX, newY, newObstacles, dist + 1});
                    }
                }
            }
        }
        return -1;
    }
}