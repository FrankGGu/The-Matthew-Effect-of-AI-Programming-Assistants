public class Solution {

import java.util.*;

public class Solution {
    int[][] dirs = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    public int minMovesToBoxToTarget(char[][] grid) {
        int m = grid.length, n = grid[0].length;
        int sx = -1, sy = -1, tx = -1, ty = -1, bx = -1, by = -1;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (grid[i][j] == 'S') {
                    sx = i;
                    sy = j;
                } else if (grid[i][j] == 'T') {
                    tx = i;
                    ty = j;
                } else if (grid[i][j] == 'B') {
                    bx = i;
                    by = j;
                }
            }
        }

        Queue<int[]> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();

        queue.offer(new int[]{sx, sy, bx, by});
        visited.add(sx + "," + sy + "," + bx + "," + by);

        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int k = 0; k < size; k++) {
                int[] state = queue.poll();
                int px = state[0], py = state[1], bx = state[2], by = state[3];

                if (bx == tx && by == ty) {
                    return steps;
                }

                for (int[] dir : dirs) {
                    int npX = px + dir[0], npY = py + dir[1];
                    if (npX >= 0 && npX < m && npY >= 0 && npY < n && grid[npX][npY] != '#') {
                        if (npX == bx && npY == by) {
                            int nbX = bx + dir[0], nbY = by + dir[1];
                            if (nbX >= 0 && nbX < m && nbY >= 0 && nbY < n && grid[nbX][nbY] != '#') {
                                String key = npX + "," + npY + "," + nbX + "," + nbY;
                                if (!visited.contains(key)) {
                                    visited.add(key);
                                    queue.offer(new int[]{npX, npY, nbX, nbY});
                                }
                            }
                        } else {
                            String key = npX + "," + npY + "," + bx + "," + by;
                            if (!visited.contains(key)) {
                                visited.add(key);
                                queue.offer(new int[]{npX, npY, bx, by});
                            }
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