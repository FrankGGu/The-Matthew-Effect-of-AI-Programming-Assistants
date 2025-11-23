import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int shortestPathAllKeys(String[] gridStr) {
        int m = gridStr.length;
        int n = gridStr[0].length();
        char[][] grid = new char[m][n];
        int startR = -1, startC = -1;
        int totalKeys = 0;

        for (int i = 0; i < m; i++) {
            grid[i] = gridStr[i].toCharArray();
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == '@') {
                    startR = i;
                    startC = j;
                } else if (grid[i][j] >= 'a' && grid[i][j] <= 'f') {
                    totalKeys++;
                }
            }
        }

        // BFS state: {row, col, keys_mask, steps}
        Queue<int[]> q = new LinkedList<>();
        // visited[row][col][keys_mask]
        boolean[][][] visited = new boolean[m][n][1 << totalKeys];

        q.offer(new int[]{startR, startC, 0, 0});
        visited[startR][startC][0] = true;

        int[][] dirs = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};

        while (!q.isEmpty()) {
            int[] curr = q.poll();
            int r = curr[0];
            int c = curr[1];
            int keys = curr[2];
            int steps = curr[3];

            if (keys == (1 << totalKeys) - 1) {
                return steps;
            }

            for (int[] dir : dirs) {
                int nr = r + dir[0];
                int nc = c + dir[1];

                if (nr < 0 || nr >= m || nc < 0 || nc >= n) {
                    continue; // Out of bounds
                }

                char cell = grid[nr][nc];

                if (cell == '#') {
                    continue; // Wall
                }

                if (cell >= 'a' && cell <= 'f') { // It's a key
                    int keyBit = 1 << (cell - 'a');
                    int newKeys = keys | keyBit;
                    if (!visited[nr][nc][newKeys]) {
                        visited[nr][nc][newKeys] = true;
                        q.offer(new int[]{nr, nc, newKeys, steps + 1});
                    }
                } else if (cell >= 'A' && cell <= 'F') { // It's a lock
                    int lockBit = 1 << (cell - 'A');
                    if ((keys & lockBit) != 0) { // Have the key for this lock
                        if (!visited[nr][nc][keys]) {
                            visited[nr][nc][keys] = true;
                            q.offer(new int[]{nr, nc, keys, steps + 1});
                        }
                    }
                    // Else, don't have the key, cannot pass, so continue (skip this neighbor)
                } else { // Empty cell '.' or starting point '@'
                    if (!visited[nr][nc][keys]) {
                        visited[nr][nc][keys] = true;
                        q.offer(new int[]{nr, nc, keys, steps + 1});
                    }
                }
            }
        }

        return -1; // No path found
    }
}