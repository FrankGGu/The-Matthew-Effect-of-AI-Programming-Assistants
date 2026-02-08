public class Solution {

import java.util.PriorityQueue;

public class Solution {
    public int findMinimumEffortPath(int[][] heights) {
        int rows = heights.length;
        int cols = heights[0].length;
        int[][] efforts = new int[rows][cols];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                efforts[i][j] = Integer.MAX_VALUE;
            }
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        pq.offer(new int[]{0, 0, 0});
        efforts[0][0] = 0;

        int[][] directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int row = curr[0];
            int col = curr[1];
            int effort = curr[2];

            if (row == rows - 1 && col == cols - 1) {
                return effort;
            }

            for (int[] dir : directions) {
                int newRow = row + dir[0];
                int newCol = col + dir[1];

                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols) {
                    int newEffort = Math.max(effort, Math.abs(heights[newRow][newCol] - heights[row][col]));
                    if (newEffort < efforts[newRow][newCol]) {
                        efforts[newRow][newCol] = newEffort;
                        pq.offer(new int[]{newRow, newCol, newEffort});
                    }
                }
            }
        }

        return 0;
    }
}
}