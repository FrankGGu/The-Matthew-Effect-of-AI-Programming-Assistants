public class Solution {

import java.util.*;

public class Solution {
    public int[] maxPoints(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[] result = new int[m * n];
        int index = 0;

        boolean[][] visited = new boolean[m][n];
        Queue<int[]> queue = new LinkedList<>();
        queue.add(new int[]{0, 0});
        visited[0][0] = true;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] cell = queue.poll();
                int x = cell[0];
                int y = cell[1];
                result[index++] = grid[x][y];

                for (int dx = -1; dx <= 1; dx++) {
                    for (int dy = -1; dy <= 1; dy++) {
                        if (dx == 0 && dy == 0) continue;
                        int nx = x + dx;
                        int ny = y + dy;
                        if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny]) {
                            visited[nx][ny] = true;
                            queue.add(new int[]{nx, ny});
                        }
                    }
                }
            }
        }

        return result;
    }
}
}