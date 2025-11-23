import java.util.LinkedList;
import java.util.Queue;

class Solution {
    private int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
    private int n;

    public int shortestBridge(int[][] grid) {
        n = grid.length;
        Queue<int[]> q = new LinkedList<>();
        boolean foundIsland = false;

        // Step 1: Find the first island using DFS and mark its cells as 2,
        // also add all its cells to the BFS queue.
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 1) {
                    dfs(grid, i, j, q);
                    foundIsland = true;
                    break; // Found the first island, exit inner loop
                }
            }
            if (foundIsland) {
                break; // Found the first island, exit outer loop
            }
        }

        // Step 2: Use BFS to expand from the first island (cells marked 2)
        // and find the shortest distance to the second island (cells marked 1).
        int distance = 0;
        while (!q.isEmpty()) {
            int size = q.size();
            for (int k = 0; k < size; k++) {
                int[] curr = q.poll();
                int r = curr[0];
                int c = curr[1];

                for (int[] dir : directions) {
                    int nr = r + dir[0];
                    int nc = c + dir[1];

                    if (nr < 0 || nr >= n || nc < 0 || nc >= n || grid[nr][nc] == 2) {
                        continue;
                    }

                    if (grid[nr][nc] == 1) {
                        return distance; // Found the second island
                    }

                    // grid[nr][nc] must be 0 (water)
                    grid[nr][nc] = 2; // Mark as visited and part of the expanded first island
                    q.offer(new int[]{nr, nc});
                }
            }
            distance++; // Increment distance after exploring all cells at current level
        }
        return -1; // Should not reach here if there are two islands
    }

    private void dfs(int[][] grid, int r, int c, Queue<int[]> q) {
        if (r < 0 || r >= n || c < 0 || c >= n || grid[r][c] != 1) {
            return;
        }

        grid[r][c] = 2; // Mark current cell as part of the first island
        q.offer(new int[]{r, c}); // Add to BFS queue

        for (int[] dir : directions) {
            dfs(grid, r + dir[0], c + dir[1], q);
        }
    }
}