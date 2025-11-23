import java.util.PriorityQueue;

class Solution {
    public int minimumEffortPath(int[][] heights) {
        int rows = heights.length;
        int cols = heights[0].length;
        int[][] effort = new int[rows][cols];
        for (int[] row : effort) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        effort[0][0] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        pq.offer(new int[]{0, 0, 0});

        int[][] directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int x = current[0], y = current[1], currEffort = current[2];

            if (x == rows - 1 && y == cols - 1) {
                return currEffort;
            }

            for (int[] dir : directions) {
                int newX = x + dir[0];
                int newY = y + dir[1];

                if (newX >= 0 && newX < rows && newY >= 0 && newY < cols) {
                    int newEffort = Math.max(currEffort, Math.abs(heights[newX][newY] - heights[x][y]));
                    if (newEffort < effort[newX][newY]) {
                        effort[newX][newY] = newEffort;
                        pq.offer(new int[]{newX, newY, newEffort});
                    }
                }
            }
        }
        return 0;
    }
}