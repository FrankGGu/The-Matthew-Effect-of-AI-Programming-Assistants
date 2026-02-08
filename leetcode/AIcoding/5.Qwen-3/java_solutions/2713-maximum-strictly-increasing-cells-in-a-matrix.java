public class Solution {

import java.util.*;

public class Solution {
    public int maxValue(int[][] matrix) {
        int m = matrix.length;
        int n = matrix[0].length;
        int[][] dp = new int[m][n];
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> matrix[a[0]][a[1]] - matrix[b[0]][b[1]]);

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                pq.offer(new int[]{i, j});
            }
        }

        int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!pq.isEmpty()) {
            int[] cell = pq.poll();
            int i = cell[0], j = cell[1];
            int maxVal = 0;
            for (int[] dir : dirs) {
                int ni = i + dir[0];
                int nj = j + dir[1];
                if (ni >= 0 && ni < m && nj >= 0 && nj < n && matrix[ni][nj] < matrix[i][j]) {
                    maxVal = Math.max(maxVal, dp[ni][nj]);
                }
            }
            dp[i][j] = maxVal + 1;
        }

        int result = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                result = Math.max(result, dp[i][j]);
            }
        }
        return result;
    }
}
}