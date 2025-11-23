public class Solution {

import java.util.*;

public class Solution {
    public int maximumMinutes(Grid grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int[][] timeToFire = new int[rows][cols];
        boolean[][] visited = new boolean[rows][cols];
        Queue<int[]> fireQueue = new LinkedList<>();

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 1) {
                    fireQueue.add(new int[]{i, j});
                    visited[i][j] = true;
                }
            }
        }

        int[] dir = {-1, 0, 1, 0, -1};
        int time = 0;

        while (!fireQueue.isEmpty()) {
            int size = fireQueue.size();
            for (int k = 0; k < size; k++) {
                int[] cell = fireQueue.poll();
                int x = cell[0];
                int y = cell[1];
                timeToFire[x][y] = time;
                for (int i = 0; i < 4; i++) {
                    int nx = x + dir[i];
                    int ny = y + dir[i + 1];
                    if (nx >= 0 && ny >= 0 && nx < rows && ny < cols && !visited[nx][ny]) {
                        visited[nx][ny] = true;
                        fireQueue.add(new int[]{nx, ny});
                    }
                }
            }
            time++;
        }

        int result = -1;
        Queue<int[]> queue = new LinkedList<>();
        boolean[][] visited2 = new boolean[rows][cols];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 0) {
                    queue.add(new int[]{i, j, 0});
                    visited2[i][j] = true;
                }
            }
        }

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int k = 0; k < size; k++) {
                int[] cell = queue.poll();
                int x = cell[0];
                int y = cell[1];
                int t = cell[2];
                if (x == 0 || x == rows - 1 || y == 0 || y == cols - 1) {
                    result = t;
                }
                for (int i = 0; i < 4; i++) {
                    int nx = x + dir[i];
                    int ny = y + dir[i + 1];
                    if (nx >= 0 && ny >= 0 && nx < rows && ny < cols && !visited2[nx][ny]) {
                        if (timeToFire[nx][ny] > t + 1 || (timeToFire[nx][ny] == t + 1 && nx == 0 || nx == rows - 1 || ny == 0 || ny == cols - 1)) {
                            visited2[nx][ny] = true;
                            queue.add(new int[]{nx, ny, t + 1});
                        }
                    }
                }
            }
        }

        return result;
    }
}
}