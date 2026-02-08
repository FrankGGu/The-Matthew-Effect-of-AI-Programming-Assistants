import java.util.PriorityQueue;
import java.util.Comparator;

class Solution {

    private static class Cell {
        int row;
        int col;
        int height;

        public Cell(int row, int col, int height) {
            this.row = row;
            this.col = col;
            this.height = height;
        }
    }

    public int trapRainWater(int[][] heightMap) {
        if (heightMap == null || heightMap.length == 0 || heightMap[0].length == 0) {
            return 0;
        }

        int m = heightMap.length;
        int n = heightMap[0].length;

        PriorityQueue<Cell> pq = new PriorityQueue<>(Comparator.comparingInt(c -> c.height));
        boolean[][] visited = new boolean[m][n];

        // Add all border cells to the priority queue
        // Top and bottom rows
        for (int j = 0; j < n; j++) {
            pq.offer(new Cell(0, j, heightMap[0][j]));
            visited[0][j] = true;
            pq.offer(new Cell(m - 1, j, heightMap[m - 1][j]));
            visited[m - 1][j] = true;
        }

        // Left and right columns (excluding corners already added)
        for (int i = 1; i < m - 1; i++) {
            pq.offer(new Cell(i, 0, heightMap[i][0]));
            visited[i][0] = true;
            pq.offer(new Cell(i, n - 1, heightMap[i][n - 1]));
            visited[i][n - 1] = true;
        }

        int waterTrapped = 0;
        int[] dr = {-1, 1, 0, 0}; // Row direction changes
        int[] dc = {0, 0, -1, 1}; // Column direction changes

        while (!pq.isEmpty()) {
            Cell current = pq.poll();

            // Explore neighbors
            for (int i = 0; i < 4; i++) {
                int newRow = current.row + dr[i];
                int newCol = current.col + dc[i];

                if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && !visited[newRow][newCol]) {
                    visited[newRow][newCol] = true;

                    waterTrapped += Math.max(0, current.height - heightMap[newRow][newCol]);

                    pq.offer(new Cell(newRow, newCol, Math.max(current.height, heightMap[newRow][newCol])));
                }
            }
        }

        return waterTrapped;
    }
}