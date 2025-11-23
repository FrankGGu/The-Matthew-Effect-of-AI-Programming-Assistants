public class Solution {

import java.util.*;

public class Solution {
    public int minMoves(char[][] classroom) {
        int m = classroom.length;
        int n = classroom[0].length;
        List<int[]> positions = new ArrayList<>();

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (classroom[i][j] == 'C') {
                    positions.add(new int[]{i, j});
                }
            }
        }

        int totalMoves = 0;
        Set<String> visited = new HashSet<>();

        for (int[] pos : positions) {
            String key = pos[0] + "," + pos[1];
            if (!visited.contains(key)) {
                Queue<int[]> queue = new LinkedList<>();
                queue.add(pos);
                visited.add(key);
                int moves = 0;

                while (!queue.isEmpty()) {
                    int size = queue.size();
                    for (int i = 0; i < size; i++) {
                        int[] current = queue.poll();
                        int x = current[0];
                        int y = current[1];

                        for (int[] dir : new int[][]{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}) {
                            int nx = x + dir[0];
                            int ny = y + dir[1];

                            if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited.contains(nx + "," + ny)) {
                                if (classroom[nx][ny] == 'C') {
                                    visited.add(nx + "," + ny);
                                    queue.add(new int[]{nx, ny});
                                } else {
                                    totalMoves += moves + 1;
                                    visited.add(nx + "," + ny);
                                }
                            }
                        }
                    }
                    moves++;
                }
            }
        }

        return totalMoves;
    }
}
}