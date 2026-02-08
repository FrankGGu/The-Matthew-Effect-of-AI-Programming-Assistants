public class Solution {

import java.util.*;

public class Solution {
    public int maximumScore(int[][] grid) {
        int rows = grid.length;
        int cols = grid[0].length;
        int score = 0;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> b[0] - a[0]);

        for (int i = 0; i < rows; i++) {
            pq.offer(new int[]{grid[i][0], i, 0});
        }

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            score += current[0];
            int row = current[1];
            int col = current[2];

            if (col + 1 < cols) {
                pq.offer(new int[]{grid[row][col + 1], row, col + 1});
            }
        }

        return score;
    }
}
}