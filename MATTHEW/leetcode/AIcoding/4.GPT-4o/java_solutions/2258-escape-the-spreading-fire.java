import java.util.*;

public class Solution {
    public int escapeFire(char[][] forest) {
        int rows = forest.length, cols = forest[0].length;
        int[][] fireTime = new int[rows][cols];
        for (int[] row : fireTime) Arrays.fill(row, Integer.MAX_VALUE);

        Queue<int[]> fireQueue = new LinkedList<>();
        for (int r = 0; r < rows; r++) {
            for (int c = 0; c < cols; c++) {
                if (forest[r][c] == 'F') {
                    fireQueue.offer(new int[]{r, c});
                    fireTime[r][c] = 0;
                }
            }
        }

        int[][] directions = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
        while (!fireQueue.isEmpty()) {
            int[] firePos = fireQueue.poll();
            for (int[] dir : directions) {
                int newRow = firePos[0] + dir[0], newCol = firePos[1] + dir[1];
                if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && forest[newRow][newCol] == '.') {
                    if (fireTime[newRow][newCol] > fireTime[firePos[0]][firePos[1]] + 1) {
                        fireTime[newRow][newCol] = fireTime[firePos[0]][firePos[1]] + 1;
                        fireQueue.offer(new int[]{newRow, newCol});
                    }
                }
            }
        }

        Queue<int[]> personQueue = new LinkedList<>();
        personQueue.offer(new int[]{0, 0});
        int escapeTime = 0;

        while (!personQueue.isEmpty()) {
            int size = personQueue.size();
            escapeTime++;
            for (int s = 0; s < size; s++) {
                int[] personPos = personQueue.poll();
                for (int[] dir : directions) {
                    int newRow = personPos[0] + dir[0], newCol = personPos[1] + dir[1];
                    if (newRow < 0 || newRow >= rows || newCol < 0 || newCol >= cols) {
                        return escapeTime;
                    }
                    if (forest[newRow][newCol] == '.' && escapeTime < fireTime[newRow][newCol]) {
                        personQueue.offer(new int[]{newRow, newCol});
                        forest[newRow][newCol] = 'P'; // Mark as visited
                    }
                }
            }
        }

        return -1;
    }
}