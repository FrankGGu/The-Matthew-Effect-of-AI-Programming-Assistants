public class Solution {

import java.util.*;

public class Solution {
    public int shortestPathAllKeys(String[] grid) {
        int m = grid.length, n = grid[0].length();
        int startRow = -1, startCol = -1;
        int keyCount = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                char c = grid[i].charAt(j);
                if (c == '@') {
                    startRow = i;
                    startCol = j;
                } else if (c >= 'a' && c <= 'f') {
                    keyCount++;
                }
            }
        }

        int targetState = (1 << keyCount) - 1;

        int[][][] dist = new int[m][n][1 << keyCount];
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                Arrays.fill(dist[i][j], -1);
            }
        }

        Queue<int[]> queue = new LinkedList<>();
        queue.add(new int[]{startRow, startCol, 0});
        dist[startRow][startCol][0] = 0;

        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int row = curr[0], col = curr[1], state = curr[2];
            int steps = dist[row][col][state];

            if (state == targetState) return steps;

            for (int[] dir : directions) {
                int newRow = row + dir[0], newCol = col + dir[1];
                if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n) {
                    char c = grid[newRow].charAt(newCol);
                    if (c == '#') continue;
                    if (c >= 'A' && c <= 'F') {
                        int key = c - 'A';
                        if ((state & (1 << key)) == 0) continue;
                    }
                    int newState = state;
                    if (c >= 'a' && c <= 'f') {
                        int key = c - 'a';
                        newState = state | (1 << key);
                    }
                    if (dist[newRow][newCol][newState] == -1) {
                        dist[newRow][newCol][newState] = steps + 1;
                        queue.add(new int[]{newRow, newCol, newState});
                    }
                }
            }
        }

        return -1;
    }
}
}