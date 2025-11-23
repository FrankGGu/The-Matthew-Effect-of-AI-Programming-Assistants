public class Solution {

import java.util.*;

public class Solution {
    public int[] maxPoints(int[][] grid, int[] queries) {
        int m = grid.length;
        int n = grid[0].length;
        int[][] sortedGrid = new int[m][n];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                sortedGrid[i][j] = grid[i][j];
            }
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        boolean[][] visited = new boolean[m][n];
        int[][] points = new int[m][n];

        pq.offer(new int[]{sortedGrid[0][0], 0, 0});
        visited[0][0] = true;

        int count = 0;
        int total = 0;

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int val = curr[0];
            int i = curr[1];
            int j = curr[2];
            count++;
            total += val;

            int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
            for (int[] dir : dirs) {
                int ni = i + dir[0];
                int nj = j + dir[1];
                if (ni >= 0 && ni < m && nj >= 0 && nj < n && !visited[ni][nj]) {
                    visited[ni][nj] = true;
                    pq.offer(new int[]{sortedGrid[ni][nj], ni, nj});
                }
            }
        }

        Arrays.sort(queries);
        int[] result = new int[queries.length];
        int idx = 0;
        int sum = 0;
        int k = 0;

        for (int q : queries) {
            while (k < m * n && sortedGrid[k / n][k % n] < q) {
                sum += sortedGrid[k / n][k % n];
                k++;
            }
            result[idx++] = sum;
        }

        return result;
    }
}
}