import java.util.*;

class Solution {
    public int minPushBox(char[][] grid) {
        int m = grid.length;
        int n = grid[0].length;
        int sx = -1, sy = -1, bx = -1, by = -1, tx = -1, ty = -1;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 'S') {
                    sx = i;
                    sy = j;
                } else if (grid[i][j] == 'B') {
                    bx = i;
                    by = j;
                } else if (grid[i][j] == 'T') {
                    tx = i;
                    ty = j;
                }
            }
        }

        int[][] dirs = {{0, 1}, {0, -1}, {1, 0}, {-1, 0}};
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{sx, sy, bx, by, 0});
        Set<String> visited = new HashSet<>();
        visited.add(sx + "," + sy + "," + bx + "," + by);

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int curSx = curr[0];
            int curSy = curr[1];
            int curBx = curr[2];
            int curBy = curr[3];
            int moves = curr[4];

            if (curBx == tx && curBy == ty) {
                return moves;
            }

            for (int[] dir : dirs) {
                int nextSx = curSx + dir[0];
                int nextSy = curSy + dir[1];

                if (nextSx < 0 || nextSx >= m || nextSy < 0 || nextSy >= n || grid[nextSx][nextSy] == '#') {
                    continue;
                }

                if (nextSx == curBx && nextSy == curBy) {
                    int nextBx = curBx + dir[0];
                    int nextBy = curBy + dir[1];

                    if (nextBx < 0 || nextBx >= m || nextBy < 0 || nextBy >= n || grid[nextBx][nextBy] == '#') {
                        continue;
                    }

                    String nextState = nextSx + "," + nextSy + "," + nextBx + "," + nextBy;
                    if (!visited.contains(nextState)) {
                        visited.add(nextState);
                        queue.offer(new int[]{nextSx, nextSy, nextBx, nextBy, moves + 1});
                    }
                } else {
                    String nextState = nextSx + "," + nextSy + "," + curBx + "," + curBy;
                    if (!visited.contains(nextState)) {
                        visited.add(nextState);
                        queue.offer(new int[]{nextSx, nextSy, curBx, curBy, moves});
                    }
                }
            }
        }

        return -1;
    }
}