import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

class Solution {
    private int m, n;
    private int[][] heights;
    private int[][] dirs = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

    public List<List<Integer>> pacificAtlantic(int[][] heights) {
        if (heights == null || heights.length == 0 || heights[0].length == 0) {
            return new ArrayList<>();
        }

        this.m = heights.length;
        this.n = heights[0].length;
        this.heights = heights;

        boolean[][] pacific = new boolean[m][n];
        boolean[][] atlantic = new boolean[m][n];

        Queue<int[]> pacificQueue = new LinkedList<>();
        Queue<int[]> atlanticQueue = new LinkedList<>();

        // Initialize Pacific Ocean cells (top row and left column)
        for (int r = 0; r < m; r++) {
            pacificQueue.offer(new int[]{r, 0});
            pacific[r][0] = true;
        }
        for (int c = 1; c < n; c++) { // Start from c=1 to avoid re-adding (0,0)
            pacificQueue.offer(new int[]{0, c});
            pacific[0][c] = true;
        }

        // Initialize Atlantic Ocean cells (bottom row and right column)
        for (int r = 0; r < m; r++) {
            atlanticQueue.offer(new int[]{r, n - 1});
            atlantic[r][n - 1] = true;
        }
        for (int c = 0; c < n - 1; c++) { // Start from c=0, end at n-2 to avoid re-adding (m-1, n-1)
            atlanticQueue.offer(new int[]{m - 1, c});
            atlantic[m - 1][c] = true;
        }

        // Perform BFS from all initial Pacific cells
        bfs(pacificQueue, pacific);
        // Perform BFS from all initial Atlantic cells
        bfs(atlanticQueue, atlantic);

        List<List<Integer>> result = new ArrayList<>();
        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                if (pacific[r][c] && atlantic[r][c]) {
                    result.add(Arrays.asList(r, c));
                }
            }
        }

        return result;
    }

    private void bfs(Queue<int[]> queue, boolean[][] visited) {
        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int r = curr[0];
            int c = curr[1];

            for (int[] dir : dirs) {
                int nr = r + dir[0];
                int nc = c + dir[1];

                // Check bounds, if not visited, and if water can flow from neighbor to current cell
                if (nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc] && heights[nr][nc] >= heights[r][c]) {
                    visited[nr][nc] = true;
                    queue.offer(new int[]{nr, nc});
                }
            }
        }
    }
}