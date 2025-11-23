class Solution {
    public int minimumEffortPath(int[][] heights) {
        int rows = heights.length;
        int cols = heights[0].length;
        int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[2] - b[2]);
        pq.offer(new int[]{0, 0, 0});
        int[][] effort = new int[rows][cols];
        for (int[] row : effort) {
            Arrays.fill(row, Integer.MAX_VALUE);
        }
        effort[0][0] = 0;

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int x = curr[0];
            int y = curr[1];
            int currEffort = curr[2];
            if (x == rows - 1 && y == cols - 1) {
                return currEffort;
            }
            for (int[] dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];
                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols) {
                    int newEffort = Math.max(currEffort, Math.abs(heights[nx][ny] - heights[x][y]));
                    if (newEffort < effort[nx][ny]) {
                        effort[nx][ny] = newEffort;
                        pq.offer(new int[]{nx, ny, newEffort});
                    }
                }
            }
        }
        return -1;
    }
}