import java.util.*;

class Solution {
    public int maximumSafenessFactor(List<List<Integer>> grid) {
        int n = grid.size();

        // Step 1: Calculate Manhattan distance to the nearest thief for all cells
        // dist[r][c] will store the minimum Manhattan distance from (r,c) to any thief.
        int[][] dist = new int[n][n];
        Queue<int[]> q = new LinkedList<>();

        // Initialize dist array and add all thief locations to the queue
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (grid.get(i).get(j) == 1) {
                    dist[i][j] = 0; // Thief cell has distance 0 to itself
                    q.offer(new int[]{i, j});
                } else {
                    dist[i][j] = Integer.MAX_VALUE; // Mark as unvisited/far from thief
                }
            }
        }

        int[] dr = {-1, 1, 0, 0}; // Directions for row
        int[] dc = {0, 0, -1, 1}; // Directions for column

        // Multi-source BFS to fill the dist array
        // This BFS calculates the shortest path (Manhattan distance) from any thief to all other cells.
        while (!q.isEmpty()) {
            int[] curr = q.poll();
            int r = curr[0];
            int c = curr[1];

            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                // If neighbor is valid and has not been visited yet (dist is MAX_VALUE)
                if (isValid(nr, nc, n) && dist[nr][nc] == Integer.MAX_VALUE) {
                    dist[nr][nc] = dist[r][c] + 1;
                    q.offer(new int[]{nr, nc});
                }
            }
        }

        // Step 2: Use Dijkstra-like BFS with a max-priority queue to find the path with maximum safeness factor
        // The priority queue stores {safeness_factor, row, col}.
        // We want to extract paths with higher safeness factor first, so it's a max-heap.
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> b[0] - a[0]);

        // maxSafeness[r][c] stores the maximum safeness factor of a path from (0,0) to (r,c) found so far.
        // Initialize with -1 to indicate no path found yet or a very low safeness.
        int[][] maxSafeness = new int[n][n];
        for (int i = 0; i < n; i++) {
            Arrays.fill(maxSafeness[i], -1);
        }

        // Start from (0,0) with its safeness factor
        maxSafeness[0][0] = dist[0][0];
        pq.offer(new int[]{dist[0][0], 0, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int currentSafeness = curr[0];
            int r = curr[1];
            int c = curr[2];

            // If we've already found a path to (r,c) with a safeness factor greater than or equal to this one,
            // we don't need to process this path as it's not better.
            if (currentSafeness < maxSafeness[r][c]) {
                continue;
            }

            // If we reached the target cell (n-1, n-1), this is the maximum safeness factor
            // for a path to it, because we are using a max-priority queue.
            if (r == n - 1 && c == n - 1) {
                return currentSafeness;
            }

            // Explore neighbors
            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (isValid(nr, nc, n)) {
                    // The safeness factor of the path to (nr, nc) through (r, c) is the minimum of
                    // the current path's safeness and the safeness of the cell (nr, nc) itself.
                    int newSafeness = Math.min(currentSafeness, dist[nr][nc]);

                    // If this new path to (nr, nc) has a higher safeness factor than any previously found path,
                    // update maxSafeness and add this new path to the priority queue.
                    if (newSafeness > maxSafeness[nr][nc]) {
                        maxSafeness[nr][nc] = newSafeness;
                        pq.offer(new int[]{newSafeness, nr, nc});
                    }
                }
            }
        }

        // This line should theoretically not be reached if a path from (0,0) to (n-1, n-1) always exists.
        // The problem implies a path always exists.
        return maxSafeness[n-1][n-1];
    }

    // Helper function to check if a cell (r, c) is within the grid boundaries.
    private boolean isValid(int r, int c, int n) {
        return r >= 0 && r < n && c >= 0 && c < n;
    }
}