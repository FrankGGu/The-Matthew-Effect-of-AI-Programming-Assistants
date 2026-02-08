public class Solution {

import java.util.*;

class Solution {
    public int[] countOperationsToEmptyMatrix(int[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int total = m * n;
        int[] result = new int[total];
        int index = 0;

        Queue<int[]> queue = new LinkedList<>();
        boolean[][] visited = new boolean[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] > 0) {
                    queue.add(new int[]{i, j});
                    visited[i][j] = true;
                }
            }
        }

        int[] directions = {-1, 0, 1, 0, -1};

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int k = 0; k < size; k++) {
                int[] cell = queue.poll();
                int i = cell[0];
                int j = cell[1];
                result[index++] = total;
                for (int d = 0; d < 4; d++) {
                    int ni = i + directions[d];
                    int nj = j + directions[d + 1];
                    if (ni >= 0 && ni < m && nj >= 0 && nj < n && !visited[ni][nj]) {
                        visited[ni][nj] = true;
                        queue.add(new int[]{ni, nj});
                    }
                }
            }
            total--;
        }

        return result;
    }
}
}