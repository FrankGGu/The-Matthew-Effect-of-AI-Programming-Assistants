import java.util.*;

class Solution {
    public int minFlips(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;
        int start = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                start |= (mat[i][j] << (i * n + j));
            }
        }

        Queue<Integer> queue = new LinkedList<>();
        Set<Integer> visited = new HashSet<>();
        queue.offer(start);
        visited.add(start);
        int steps = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int curr = queue.poll();
                if (curr == 0) {
                    return steps;
                }

                for (int r = 0; r < m; r++) {
                    for (int c = 0; c < n; c++) {
                        int next = curr ^ (1 << (r * n + c));
                        if (r > 0) next ^= (1 << ((r - 1) * n + c));
                        if (r < m - 1) next ^= (1 << ((r + 1) * n + c));
                        if (c > 0) next ^= (1 << (r * n + c - 1));
                        if (c < n - 1) next ^= (1 << (r * n + c + 1));

                        if (!visited.contains(next)) {
                            queue.offer(next);
                            visited.add(next);
                        }
                    }
                }
            }
            steps++;
        }

        return -1;
    }
}