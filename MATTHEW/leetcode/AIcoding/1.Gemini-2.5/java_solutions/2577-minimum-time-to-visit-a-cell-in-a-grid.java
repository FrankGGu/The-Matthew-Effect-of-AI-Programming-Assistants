import java.util.PriorityQueue;
import java.util.Arrays;

class Solution {
    public int minimumTime(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;

        // Base case: If the starting cell is also the target cell, time is 0.
        if (m == 1 && n == 1) {
            return 0;
        }

        // Special condition mentioned in the problem description:
        // "Note that it is impossible to reach (m-1, n-1) if grid[0][1] > 1 and grid[1][0] > 1."
        // This condition implies that both (0,1) and (1,0) must exist, meaning m >= 2 and n >= 2.
        // If this condition is met, we return -1 as per the problem statement.
        if (grid[0][1] > 1 && grid[1][0] > 1) {
            return -1;
        }

        // Dijkstra's algorithm to find the shortest path
        // dist[r][c] stores the minimum time required to enter cell (r, c)
        int[][] dist = new int[m][n];
        for (int i = 0; i < m; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
        }

        // PriorityQueue stores int[] {time, row, col}
        // It is sorted by 'time' in ascending order to process cells with minimum time first.
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        // Start at (0, 0) at time 0
        dist[0][0] = 0;
        pq.offer(new int[]{0, 0, 0});

        // Directions for moving to adjacent cells (up, down, left, right)
        int[] dr = {-1, 1, 0, 0};
        int[] dc = {0, 0, -1, 1};

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int currentTime = curr[0];
            int r = curr[1];
            int c = curr[2];

            // If we have already found a shorter path to this cell, skip this entry
            if (currentTime > dist[r][c]) {
                continue;
            }

            // If we reached the target cell (m-1, n-1), return the current time
            if (r == m - 1 && c == n - 1) {
                return currentTime;
            }

            // Explore all four neighbors
            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                // Check if the neighbor is within the grid boundaries
                if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    // Time to arrive at the neighbor (nr, nc) from the current cell (r, c)
                    int arrivalTime = currentTime + 1;

                    // Determine the actual time we can enter (nr, nc)
                    // We can only enter if arrivalTime >= grid[nr][nc].
                    // If we arrive too early, we must wait until grid[nr][nc].
                    int timeToEnterNeighbor;
                    if (arrivalTime < grid[nr][nc]) {
                        timeToEnterNeighbor = grid[nr][nc];
                    } else {
                        // If we arrive on time or later, we can enter immediately
                        timeToEnterNeighbor = arrivalTime;
                    }

                    // If this path offers a shorter time to enter (nr, nc), update and add to PQ
                    if (timeToEnterNeighbor < dist[nr][nc]) {
                        dist[nr][nc] = timeToEnterNeighbor;
                        pq.offer(new int[]{timeToEnterNeighbor, nr, nc});
                    }
                }
            }
        }

        // If the target cell (m-1, n-1) is unreachable, dist[m-1][n-1] will remain MAX_VALUE
        // and the loop will finish without returning.
        return -1;
    }
}