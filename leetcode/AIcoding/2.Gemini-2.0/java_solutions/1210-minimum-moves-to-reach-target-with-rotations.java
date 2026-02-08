import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int minimumMoves(int[][] grid) {
        int n = grid.length;
        if (grid[n - 1][n - 1] == 1 || grid[n - 1][n - 2] == 1) return -1;

        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0, 0}); // row, col, state (0: horizontal, 1: vertical)

        boolean[][][] visited = new boolean[n][n][2];
        visited[0][0][0] = true;

        int moves = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] curr = queue.poll();
                int row = curr[0];
                int col = curr[1];
                int state = curr[2];

                if (row == n - 1 && col == n - 2 && state == 0) {
                    return moves;
                }

                // Move forward
                if (state == 0) {
                    if (col + 2 < n && grid[row][col + 2] == 0 && !visited[row][col + 1][0]) {
                        queue.offer(new int[]{row, col + 1, 0});
                        visited[row][col + 1][0] = true;
                    }
                } else {
                    if (row + 2 < n && grid[row + 2][col] == 0 && !visited[row + 1][col][1]) {
                        queue.offer(new int[]{row + 1, col, 1});
                        visited[row + 1][col][1] = true;
                    }
                }

                // Move down/right
                if (state == 0) {
                    if (row + 1 < n && grid[row + 1][col] == 0 && grid[row + 1][col + 1] == 0 && !visited[row + 1][col][0]) {
                        queue.offer(new int[]{row + 1, col, 0});
                        visited[row + 1][col][0] = true;
                    }
                } else {
                    if (col + 1 < n && grid[row][col + 1] == 0 && grid[row + 1][col + 1] == 0 && !visited[row][col + 1][1]) {
                        queue.offer(new int[]{row, col + 1, 1});
                        visited[row][col + 1][1] = true;
                    }
                }

                // Rotate
                if (state == 0) {
                    if (row + 1 < n && grid[row + 1][col] == 0 && grid[row + 1][col + 1] == 0 && !visited[row][col][1]) {
                        queue.offer(new int[]{row, col, 1});
                        visited[row][col][1] = true;
                    }
                } else {
                    if (col + 1 < n && grid[row][col + 1] == 0 && grid[row + 1][col + 1] == 0 && !visited[row][col][0]) {
                        queue.offer(new int[]{row, col, 0});
                        visited[row][col][0] = true;
                    }
                }
            }
            moves++;
        }

        return -1;
    }
}