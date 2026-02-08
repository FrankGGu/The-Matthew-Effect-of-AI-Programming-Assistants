public class Solution {

import java.util.*;

public class Solution {
    public int trapRainWater(int[][] heightMap) {
        if (heightMap == null || heightMap.length < 3 || heightMap[0].length < 3) {
            return 0;
        }

        int rows = heightMap.length;
        int cols = heightMap[0].length;

        boolean[][] visited = new boolean[rows][cols];
        PriorityQueue<int[]> minHeap = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (i == 0 || i == rows - 1 || j == 0 || j == cols - 1) {
                    minHeap.offer(new int[]{heightMap[i][j], i, j});
                    visited[i][j] = true;
                }
            }
        }

        int result = 0;
        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!minHeap.isEmpty()) {
            int[] current = minHeap.poll();
            int height = current[0];
            int x = current[1];
            int y = current[2];

            for (int[] dir : directions) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && !visited[nx][ny]) {
                    visited[nx][ny] = true;
                    if (heightMap[nx][ny] < height) {
                        result += height - heightMap[nx][ny];
                    }
                    minHeap.offer(new int[]{Math.max(height, heightMap[nx][ny]), nx, ny});
                }
            }
        }

        return result;
    }
}
}