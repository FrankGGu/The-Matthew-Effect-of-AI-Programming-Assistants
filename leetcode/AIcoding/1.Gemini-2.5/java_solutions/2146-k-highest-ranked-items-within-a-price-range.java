import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

class Solution {
    public List<List<Integer>> highestRankedKItems(int[][] grid, int[] pricing, int[] start, int k) {
        int m = grid.length;
        int n = grid[0].length;

        Queue<int[]> queue = new LinkedList<>();
        boolean[][] visited = new boolean[m][n];

        List<int[]> candidates = new ArrayList<>(); // Stores [distance, price, row, col]

        int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}}; // Up, Down, Left, Right

        // Start BFS from the given start cell
        queue.offer(new int[]{start[0], start[1], 0}); // {row, col, distance}
        visited[start[0]][start[1]] = true;

        // Check if the starting cell itself is an item within the price range
        if (grid[start[0]][start[1]] > 1) {
            int price = grid[start[0]][start[1]];
            if (price >= pricing[0] && price <= pricing[1]) {
                candidates.add(new int[]{0, price, start[0], start[1]});
            }
        }

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int r = current[0];
            int c = current[1];
            int dist = current[2];

            for (int[] dir : dirs) {
                int nr = r + dir[0];
                int nc = c + dir[1];

                // Check bounds, visited status, and if it's an obstacle (grid value 0)
                if (nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc] && grid[nr][nc] != 0) {
                    visited[nr][nc] = true;
                    queue.offer(new int[]{nr, nc, dist + 1});

                    // If it's an item and its price is within the specified range
                    if (grid[nr][nc] > 1) {
                        int price = grid[nr][nc];
                        if (price >= pricing[0] && price <= pricing[1]) {
                            candidates.add(new int[]{dist + 1, price, nr, nc});
                        }
                    }
                }
            }
        }

        // Sort the collected candidate items based on the ranking criteria
        Collections.sort(candidates, (a, b) -> {
            // 1. Shorter distance first
            if (a[0] != b[0]) {
                return a[0] - b[0];
            }
            // 2. Lower price first
            if (a[1] != b[1]) {
                return a[1] - b[1];
            }
            // 3. Smaller row index first
            if (a[2] != b[2]) {
                return a[2] - b[2];
            }
            // 4. Smaller column index first
            return a[3] - b[3];
        });

        // Select the top K items
        List<List<Integer>> result = new ArrayList<>();
        for (int i = 0; i < Math.min(k, candidates.size()); i++) {
            List<Integer> itemCoords = new ArrayList<>();
            itemCoords.add(candidates.get(i)[2]); // row
            itemCoords.add(candidates.get(i)[3]); // col
            result.add(itemCoords);
        }

        return result;
    }
}