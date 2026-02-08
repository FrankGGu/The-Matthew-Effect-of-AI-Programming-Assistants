import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public boolean hasValidPath(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        // street_openings[street_type] stores an array of allowed relative (dr, dc) moves.
        // For example, street 1 (left-right) allows moving to (r, c-1) and (r, c+1),
        // represented as {0, -1} and {0, 1}.
        // Index 0 is a placeholder since street types are 1-6.
        int[][][] street_openings = {
            {}, // Placeholder for street type 0
            {{0, -1}, {0, 1}},   // 1: left, right
            {{-1, 0}, {1, 0}},   // 2: up, down
            {{0, -1}, {1, 0}},   // 3: left, down
            {{0, 1}, {1, 0}},    // 4: right, down
            {{0, -1}, {-1, 0}},  // 5: left, up
            {{0, 1}, {-1, 0}}    // 6: right, up
        };

        Queue<int[]> queue = new LinkedList<>();
        boolean[][] visited = new boolean[m][n];

        // Start BFS from (0,0)
        queue.offer(new int[]{0, 0});
        visited[0][0] = true;

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int r = current[0];
            int c = current[1];

            // If we reached the target cell (m-1, n-1)
            if (r == m - 1 && c == n - 1) {
                return true;
            }

            int currentStreetType = grid[r][c];

            // Explore possible moves from the current cell based on its street type
            for (int[] dir : street_openings[currentStreetType]) {
                int dr = dir[0]; // Change in row
                int dc = dir[1]; // Change in column

                int nr = r + dr; // Neighbor row
                int nc = c + dc; // Neighbor column

                // Check if the neighbor is within grid boundaries
                if (nr < 0 || nr >= m || nc < 0 || nc >= n) {
                    continue;
                }

                // If the neighbor has already been visited, skip it
                if (visited[nr][nc]) {
                    continue;
                }

                // Check if the neighbor street type can connect back to the current cell.
                // The required connection for the neighbor is the opposite direction of (dr, dc).
                int requiredDr = -dr;
                int requiredDc = -dc;

                boolean canConnectBack = false;
                int neighborStreetType = grid[nr][nc];
                for (int[] neighborDir : street_openings[neighborStreetType]) {
                    if (neighborDir[0] == requiredDr && neighborDir[1] == requiredDc) {
                        canConnectBack = true;
                        break;
                    }
                }

                // If the neighbor can connect back, add it to the queue and mark as visited
                if (canConnectBack) {
                    visited[nr][nc] = true;
                    queue.offer(new int[]{nr, nc});
                }
            }
        }

        // If the BFS completes and the target cell was not reached
        return false;
    }
}