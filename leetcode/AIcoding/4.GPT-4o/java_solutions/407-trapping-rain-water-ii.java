import java.util.PriorityQueue;

public class Solution {
    public int trapRainWater(int[][] heightMap) {
        if (heightMap == null || heightMap.length == 0 || heightMap[0].length == 0) return 0;

        int rows = heightMap.length, cols = heightMap[0].length;
        boolean[][] visited = new boolean[rows][cols];
        PriorityQueue<int[]> minHeap = new PriorityQueue<>((a, b) -> a[2] - b[2]);

        for (int r = 0; r < rows; r++) {
            visited[r][0] = true;
            visited[r][cols - 1] = true;
            minHeap.offer(new int[] { r, 0, heightMap[r][0] });
            minHeap.offer(new int[] { r, cols - 1, heightMap[r][cols - 1] });
        }

        for (int c = 0; c < cols; c++) {
            visited[0][c] = true;
            visited[rows - 1][c] = true;
            minHeap.offer(new int[] { 0, c, heightMap[0][c] });
            minHeap.offer(new int[] { rows - 1, c, heightMap[rows - 1][c] });
        }

        int waterTrapped = 0;
        int[][] directions = { { 1, 0 }, { -1, 0 }, { 0, 1 }, { 0, -1 } };

        while (!minHeap.isEmpty()) {
            int[] cell = minHeap.poll();
            int x = cell[0], y = cell[1], height = cell[2];

            for (int[] dir : directions) {
                int newX = x + dir[0], newY = y + dir[1];
                if (newX >= 0 && newX < rows && newY >= 0 && newY < cols && !visited[newX][newY]) {
                    visited[newX][newY] = true;
                    waterTrapped += Math.max(0, height - heightMap[newX][newY]);
                    minHeap.offer(new int[] { newX, newY, Math.max(height, heightMap[newX][newY]) });
                }
            }
        }
        return waterTrapped;
    }
}