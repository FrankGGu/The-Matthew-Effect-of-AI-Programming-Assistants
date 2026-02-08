public class Solution {

import java.util.*;

public class Solution {
    public int shortestPathAllKeys(String[] grid) {
        int n = grid.length;
        int m = grid[0].length();
        int keyCount = 0;
        int startRow = -1, startCol = -1;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                char c = grid[i].charAt(j);
                if (c == '@') {
                    startRow = i;
                    startCol = j;
                } else if (c >= 'a' && c <= 'f') {
                    keyCount++;
                }
            }
        }

        int targetMask = (1 << keyCount) - 1;
        int[][] directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        boolean[][][] visited = new boolean[n][m][1 << keyCount];

        Queue<int[]> queue = new LinkedList<>();
        queue.add(new int[]{startRow, startCol, 0});
        visited[startRow][startCol][0] = true;

        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] current = queue.poll();
                int row = current[0];
                int col = current[1];
                int mask = current[2];

                if (mask == targetMask) {
                    return steps;
                }

                for (int[] dir : directions) {
                    int newRow = row + dir[0];
                    int newCol = col + dir[1];

                    if (newRow >= 0 && newRow < n && newCol >= 0 && newCol < m) {
                        char c = grid[newRow].charAt(newCol);
                        if (c == '#') continue;

                        int newMask = mask;
                        if (c >= 'a' && c <= 'f') {
                            newMask |= 1 << (c - 'a');
                        }

                        if (!visited[newRow][newCol][newMask]) {
                            visited[newRow][newCol][newMask] = true;
                            queue.add(new int[]{newRow, newCol, newMask});
                        }
                    }
                }
            }
            steps++;
        }

        return -1;
    }
}
}