import java.util.*;

class Solution {
    public int[] maxPoints(int[][] grid, int[] queries) {
        int R = grid.length;
        int C = grid[0.length];

        // Step 1: Dijkstra-like algorithm to find the minimum maximum path value to each cell
        int[][] minPathValue = new int[R][C];
        for (int i = 0; i < R; i++) {
            Arrays.fill(minPathValue[i], Integer.MAX_VALUE);
        }

        // PriorityQueue stores {max_val_on_path, row, col}
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        minPathValue[0][0] = grid[0][0];
        pq.offer(new int[]{grid[0][0], 0, 0});

        int[] dr = {-1, 1, 0, 0};
        int[] dc = {0, 0, -1, 1};

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int val = curr[0];
            int r = curr[1];
            int c = curr[2];

            if (val > minPathValue[r][c]) {
                continue;
            }

            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < R && nc >= 0 && nc < C) {
                    int newMaxVal = Math.max(val, grid[nr][nc]);
                    if (newMaxVal < minPathValue[nr][nc]) {
                        minPathValue[nr][nc] = newMaxVal;
                        pq.offer(new int[]{newMaxVal, nr, nc});
                    }
                }
            }
        }

        // Step 2: Process queries offline
        // Store queries with their original indices
        List<int[]> queryPairs = new ArrayList<>();
        for (int i = 0; i < queries.length; i++) {
            queryPairs.add(new int[]{queries[i], i});
        }

        // Sort queries by their value
        queryPairs.sort((a, b) -> a[0] - b[0]);

        // Collect all reachable cells and their minPathValue
        List<Integer> cellValues = new ArrayList<>();
        for (int i = 0; i < R; i++) {
            for (int j = 0; j < C; j++) {
                if (minPathValue[i][j] != Integer.MAX_VALUE) {
                    cellValues.add(minPathValue[i][j]);
                }
            }
        }

        // Sort the minPathValues of reachable cells
        Collections.sort(cellValues);

        int[] ans = new int[queries.length];
        int cellIdx = 0;
        int reachableCount = 0;

        for (int[] queryPair : queryPairs) {
            int qVal = queryPair[0];
            int originalIdx = queryPair[1];

            // Add cells whose minPathValue is strictly less than current query value
            while (cellIdx < cellValues.size() && cellValues.get(cellIdx) < qVal) {
                reachableCount++;
                cellIdx++;
            }
            ans[originalIdx] = reachableCount;
        }

        return ans;
    }
}