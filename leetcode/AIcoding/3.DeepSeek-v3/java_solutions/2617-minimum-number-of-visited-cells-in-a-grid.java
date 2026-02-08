import java.util.*;

class Solution {
    public int minimumVisitedCells(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] dist = new int[m][n];
        for (int[] row : dist) {
            Arrays.fill(row, -1);
        }
        dist[0][0] = 1;

        PriorityQueue<int[]> rowHeap = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        PriorityQueue<int[]> colHeap = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                while (!rowHeap.isEmpty() && rowHeap.peek()[1] < j) {
                    rowHeap.poll();
                }
                if (!rowHeap.isEmpty() && dist[i][j] == -1) {
                    dist[i][j] = rowHeap.peek()[0] + 1;
                }

                while (!colHeap.isEmpty() && colHeap.peek()[1] < i) {
                    colHeap.poll();
                }
                if (!colHeap.isEmpty() && dist[i][j] == -1) {
                    dist[i][j] = colHeap.peek()[0] + 1;
                }

                if (dist[i][j] != -1) {
                    int val = grid[i][j];
                    if (val > 0) {
                        rowHeap.offer(new int[]{dist[i][j], j + val});
                        colHeap.offer(new int[]{dist[i][j], i + val});
                    }
                }
            }
            rowHeap.clear();
        }

        return dist[m - 1][n - 1];
    }
}