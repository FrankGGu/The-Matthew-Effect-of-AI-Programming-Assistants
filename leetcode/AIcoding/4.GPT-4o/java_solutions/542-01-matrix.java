import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int[][] updateMatrix(int[][] mat) {
        int rows = mat.length;
        int cols = mat[0].length;
        int[][] dist = new int[rows][cols];
        boolean[][] visited = new boolean[rows][cols];
        Queue<int[]> queue = new LinkedList<>();

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (mat[i][j] == 0) {
                    queue.offer(new int[]{i, j});
                    visited[i][j] = true;
                } else {
                    dist[i][j] = Integer.MAX_VALUE;
                }
            }
        }

        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        while (!queue.isEmpty()) {
            int[] point = queue.poll();
            for (int[] dir : directions) {
                int newRow = point[0] + dir[0];
                int newCol = point[1] + dir[1];
                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && !visited[newRow][newCol]) {
                    visited[newRow][newCol] = true;
                    dist[newRow][newCol] = dist[point[0]][point[1]] + 1;
                    queue.offer(new int[]{newRow, newCol});
                }
            }
        }

        return dist;
    }
}