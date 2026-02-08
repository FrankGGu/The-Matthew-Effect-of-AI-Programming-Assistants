import java.util.*;

class Solution {
    public int[][] highestPeak(int[][] isWater) {
        int m = isWater.length, n = isWater[0].length;
        int[][] height = new int[m][n];
        Queue<int[]> queue = new LinkedList<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (isWater[i][j] == 1) {
                    height[i][j] = 0;
                    queue.offer(new int[]{i, j});
                } else {
                    height[i][j] = -1;
                }
            }
        }

        int[][] directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
        int h = 1;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] pos = queue.poll();
                for (int[] dir : directions) {
                    int newX = pos[0] + dir[0];
                    int newY = pos[1] + dir[1];
                    if (newX >= 0 && newX < m && newY >= 0 && newY < n && height[newX][newY] == -1) {
                        height[newX][newY] = h;
                        queue.offer(new int[]{newX, newY});
                    }
                }
            }
            h++;
        }

        return height;
    }
}