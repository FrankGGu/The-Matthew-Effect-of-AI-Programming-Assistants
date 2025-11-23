public class Solution {

import java.util.*;

public class Solution {
    public int shortestPath(int[][] grid, int k) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        Queue<int[]> queue = new LinkedList<>();
        boolean[][] visited = new boolean[m][n];
        queue.add(new int[]{0, 0, k});
        visited[0][0] = true;
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] current = queue.poll();
                int x = current[0];
                int y = current[1];
                int rem = current[2];
                if (x == m - 1 && y == n - 1) {
                    return steps;
                }
                for (int[] dir : directions) {
                    int nx = x + dir[0];
                    int ny = y + dir[1];
                    if (nx >= 0 && ny >= 0 && nx < m && ny < n && !visited[nx][ny]) {
                        if (grid[nx][ny] == 1) {
                            if (rem > 0) {
                                visited[nx][ny] = true;
                                queue.add(new int[]{nx, ny, rem - 1});
                            }
                        } else {
                            visited[nx][ny] = true;
                            queue.add(new int[]{nx, ny, rem});
                        }
                    }
                }
            }
            steps++;
        }
        return -1;
    }
}
}