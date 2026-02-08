import java.util.*;

class Solution {
    public int shortestPathAllKeys(String[] grid) {
        int m = grid.length, n = grid[0].length();
        int totalKeys = 0;
        int startX = -1, startY = -1;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i].charAt(j) == '@') {
                    startX = i;
                    startY = j;
                }
                if (Character.isLowerCase(grid[i].charAt(j))) {
                    totalKeys++;
                }
            }
        }

        int targetMask = (1 << totalKeys) - 1;
        Queue<int[]> queue = new LinkedList<>();
        boolean[][][] visited = new boolean[m][n][1 << totalKeys];

        queue.offer(new int[]{startX, startY, 0, 0});
        visited[startX][startY][0] = true;

        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] curr = queue.poll();
                int x = curr[0], y = curr[1], keys = curr[2];

                if (keys == targetMask) {
                    return steps;
                }

                for (int[] dir : directions) {
                    int newX = x + dir[0], newY = y + dir[1];
                    if (newX < 0 || newX >= m || newY < 0 || newY >= n) continue;
                    char cell = grid[newX].charAt(newY);

                    if (cell == '#') continue;

                    int newKeys = keys;
                    if (Character.isLowerCase(cell)) {
                        newKeys |= (1 << (cell - 'a'));
                    } else if (Character.isUpperCase(cell)) {
                        if ((keys & (1 << (cell - 'A'))) == 0) continue;
                    }

                    if (!visited[newX][newY][newKeys]) {
                        visited[newX][newY][newKeys] = true;
                        queue.offer(new int[]{newX, newY, newKeys});
                    }
                }
            }
            steps++;
        }
        return -1;
    }
}