import java.util.*;

class Solution {
    public int minimumMoves(int[][] grid) {
        int n = grid.length;
        Queue<int[]> queue = new LinkedList<>();
        Set<String> visited = new HashSet<>();
        queue.offer(new int[]{0, 0, 0, 1});
        visited.add("0,0,0,1");
        int moves = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] current = queue.poll();
                int x1 = current[0], y1 = current[1];
                int x2 = current[2], y2 = current[3];

                if (x1 == n - 1 && y1 == n - 2 && x2 == n - 1 && y2 == n - 1) {
                    return moves;
                }

                // Move right
                if (y2 + 1 < n && grid[x2][y2 + 1] == 0) {
                    if (x1 == x2) { // horizontal
                        String key = x1 + "," + (y1 + 1) + "," + x2 + "," + (y2 + 1);
                        if (!visited.contains(key)) {
                            visited.add(key);
                            queue.offer(new int[]{x1, y1 + 1, x2, y2 + 1});
                        }
                    }
                }

                // Move down
                if (x2 + 1 < n && grid[x2 + 1][y2] == 0) {
                    if (y1 == y2) { // vertical
                        String key = (x1 + 1) + "," + y1 + "," + (x2 + 1) + "," + y2;
                        if (!visited.contains(key)) {
                            visited.add(key);
                            queue.offer(new int[]{x1 + 1, y1, x2 + 1, y2});
                        }
                    }
                }

                // Rotate clockwise
                if (x1 == x2 && y2 == y1 + 1) { // horizontal
                    if (x1 + 1 < n && grid[x1 + 1][y1] == 0 && grid[x2 + 1][y2] == 0) {
                        String key = x1 + "," + y1 + "," + (x1 + 1) + "," + y1;
                        if (!visited.contains(key)) {
                            visited.add(key);
                            queue.offer(new int[]{x1, y1, x1 + 1, y1});
                        }
                    }
                }

                // Rotate counter-clockwise
                if (y1 == y2 && x2 == x1 + 1) { // vertical
                    if (y1 + 1 < n && grid[x1][y1 + 1] == 0 && grid[x2][y2 + 1] == 0) {
                        String key = x1 + "," + y1 + "," + x1 + "," + (y1 + 1);
                        if (!visited.contains(key)) {
                            visited.add(key);
                            queue.offer(new int[]{x1, y1, x1, y1 + 1});
                        }
                    }
                }
            }
            moves++;
        }
        return -1;
    }
}