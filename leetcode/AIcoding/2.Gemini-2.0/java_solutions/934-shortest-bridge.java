import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int shortestBridge(int[][] grid) {
        int n = grid.length;
        boolean found = false;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    dfs(grid, i, j);
                    found = true;
                    break;
                }
            }
            if (found) break;
        }

        Queue<int[]> queue = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 2) {
                    queue.offer(new int[]{i, j});
                }
            }
        }

        int steps = 0;
        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] curr = queue.poll();
                int row = curr[0];
                int col = curr[1];

                for (int[] dir : directions) {
                    int newRow = row + dir[0];
                    int newCol = col + dir[1];

                    if (newRow >= 0 && newRow < n && newCol >= 0 && newCol < n) {
                        if (grid[newRow][newCol] == 1) {
                            return steps;
                        } else if (grid[newRow][newCol] == 0) {
                            grid[newRow][newCol] = 2;
                            queue.offer(new int[]{newRow, newCol});
                        }
                    }
                }
            }
            steps++;
        }

        return -1;
    }

    private void dfs(int[][] grid, int row, int col) {
        int n = grid.length;
        if (row < 0 || row >= n || col < 0 || col >= n || grid[row][col] != 1) {
            return;
        }

        grid[row][col] = 2;
        dfs(grid, row + 1, col);
        dfs(grid, row - 1, col);
        dfs(grid, row, col + 1);
        dfs(grid, row, col - 1);
    }
}