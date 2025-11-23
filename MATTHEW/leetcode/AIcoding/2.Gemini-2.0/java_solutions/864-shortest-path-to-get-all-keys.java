import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Set;

class Solution {
    public int shortestPathAllKeys(String[] grid) {
        int m = grid.length;
        int n = grid[0].length();
        int allKeys = 0;
        int startX = 0, startY = 0;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                char c = grid[i].charAt(j);
                if (c >= 'a' && c <= 'f') {
                    allKeys |= (1 << (c - 'a'));
                } else if (c == '@') {
                    startX = i;
                    startY = j;
                }
            }
        }

        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{startX, startY, 0, 0}); // x, y, keys, steps
        Set<String> visited = new HashSet<>();
        visited.add(startX + "," + startY + "," + 0);

        int[][] directions = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int x = curr[0];
            int y = curr[1];
            int keys = curr[2];
            int steps = curr[3];

            if (keys == allKeys) {
                return steps;
            }

            for (int[] dir : directions) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < m && ny >= 0 && ny < n) {
                    char nextChar = grid[nx].charAt(ny);

                    if (nextChar == '#') {
                        continue;
                    }

                    if (nextChar >= 'A' && nextChar <= 'F' && (keys & (1 << (nextChar - 'A'))) == 0) {
                        continue;
                    }

                    int nextKeys = keys;
                    if (nextChar >= 'a' && nextChar <= 'f') {
                        nextKeys |= (1 << (nextChar - 'a'));
                    }

                    String nextState = nx + "," + ny + "," + nextKeys;
                    if (!visited.contains(nextState)) {
                        visited.add(nextState);
                        queue.offer(new int[]{nx, ny, nextKeys, steps + 1});
                    }
                }
            }
        }

        return -1;
    }
}