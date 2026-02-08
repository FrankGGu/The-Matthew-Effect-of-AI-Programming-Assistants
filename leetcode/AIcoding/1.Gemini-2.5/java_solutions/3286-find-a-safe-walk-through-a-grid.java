import java.util.*;

class Solution {
    public int maximumSafenessFactor(List<List<Integer>> grid) {
        int n = grid.size();

        // Step 1: Calculate safeness factor for all cells using multi-source BFS
        // safenessGrid[r][c] will store the minimum Manhattan distance from (r,c) to any thief
        int[][] safenessGrid = new int[n][n];
        Queue<int[]> q = new LinkedList<>();

        // Directions for BFS (up, down, left, right)
        int[][] dirs = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        // Initialize safenessGrid and queue with thief locations
        for (int r = 0; r < n; r++) {
            for (int c = 0; c < n; c++) {
                if (grid.get(r).get(c) == 1) { // Cell contains a thief
                    safenessGrid[r][c] = 0; // Distance to nearest thief is 0 for thief cells
                    q.offer(new int[]{r, c}); // Add thief cell to queue
                } else { // Empty cell
                    safenessGrid[r][c] = Integer.MAX_VALUE; // Initialize with a large value (unvisited/infinite distance)
                }
            }
        }

        // Perform BFS to calculate minimum Manhattan distance to any thief for all cells
        // This is a standard multi-source BFS for all-pairs shortest path in an unweighted graph
        while (!q.isEmpty()) {
            int[] curr = q.poll();
            int r = curr[0];
            int c = curr[1];

            for (int[] dir : dirs) {
                int nr = r + dir[0];
                int nc = c + dir[1];

                // Check bounds
                if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                    // If this neighbor has not been visited yet, or we found a shorter path
                    if (safenessGrid[nr][nc] > safenessGrid[r][c] + 1) {
                        safenessGrid[nr][nc] = safenessGrid[r][c] + 1;
                        q.offer(new int[]{nr, nc});
                    }
                }
            }
        }

        // Step 2: Find the path from (0,0) to (n-1, n-1) with the maximum minimum safeness factor
        // This can be solved using a Dijkstra-like approach with a max-heap priority queue.
        // The priority queue stores {current_min_safeness_on_path, row, col}
        // We want to prioritize paths that have a higher minimum safeness factor.
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> b[0] - a[0]); // Max-heap

        // maxSafenessPath[r][c] stores the maximum minimum safeness factor found so far to reach (r,c)
        // Initialize with -1 to indicate unvisited or a very low safeness
        int[][] maxSafenessPath = new int[n][n];
        for (int r = 0; r < n; r++) {
            Arrays.fill(maxSafenessPath[r], -1);
        }

        // Start from (0,0) with its initial safeness factor
        pq.offer(new int[]{safenessGrid[0][0], 0, 0});
        maxSafenessPath[0][0] = safenessGrid[0][0];

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int currentMinSafeness = curr[0];
            int r = curr[1];
            int c = curr[2];

            // If we reached the destination (n-1, n-1), this is the maximum possible
            // minimum safeness factor for a path to the destination.
            if (r == n - 1 && c == n - 1) {
                return currentMinSafeness;
            }

            // Explore neighbors
            for (int[] dir : dirs) {
                int nr = r + dir[0];
                int nc = c + dir[1];

                // Check bounds
                if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                    // The safeness factor of the path through (nr,nc) is the minimum of
                    // the current path's minimum safeness and the safeness of cell (nr,nc) itself.
                    int newMinSafeness = Math.min(currentMinSafeness, safenessGrid[nr][nc]);

                    // If this new path to (nr,nc) has a higher minimum safeness factor
                    // than any previously found path to (nr,nc), update and add to PQ.
                    if (newMinSafeness > maxSafenessPath[nr][nc]) {
                        maxSafenessPath[nr][nc] = newMinSafeness;
                        pq.offer(new int[]{newMinSafeness, nr, nc});
                    }
                }
            }
        }

        // This line should theoretically not be reached for valid inputs where a path exists.
        // If (0,0) or (n-1,n-1) are thieves and no other path exists, the answer would be 0.
        // The algorithm handles this by returning 0 if safenessGrid[0][0] is 0.
        // If no path exists at all, this might be reached.
        return 0; 
    }
}