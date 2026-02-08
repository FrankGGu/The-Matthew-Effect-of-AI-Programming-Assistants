import java.util.*;

class Solution {
    public int minFlips(int[][] mat) {
        int m = mat.length, n = mat[0].length;
        int target = 0;
        int start = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                start |= mat[i][j] << (i * n + j);
            }
        }

        Queue<Integer> queue = new LinkedList<>();
        Set<Integer> visited = new HashSet<>();
        queue.offer(start);
        visited.add(start);
        int steps = 0;

        int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}, {0, 0}};

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int k = 0; k < size; k++) {
                int curr = queue.poll();
                if (curr == target) {
                    return steps;
                }
                for (int i = 0; i < m; i++) {
                    for (int j = 0; j < n; j++) {
                        int next = curr;
                        for (int[] dir : dirs) {
                            int x = i + dir[0];
                            int y = j + dir[1];
                            if (x >= 0 && x < m && y >= 0 && y < n) {
                                next ^= 1 << (x * n + y);
                            }
                        }
                        if (!visited.contains(next)) {
                            visited.add(next);
                            queue.offer(next);
                        }
                    }
                }
            }
            steps++;
        }
        return -1;
    }
}