import java.util.LinkedList;
import java.util.Queue;
import java.util.Set;
import java.util.HashSet;

class Solution {
    public int minFlips(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;

        int initialState = 0;
        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                if (mat[r][c] == 1) {
                    initialState |= (1 << (r * n + c));
                }
            }
        }

        Queue<int[]> queue = new LinkedList<>();
        Set<Integer> visited = new HashSet<>();

        queue.offer(new int[]{initialState, 0});
        visited.add(initialState);

        int[] dr = {-1, 1, 0, 0, 0};
        int[] dc = {0, 0, -1, 1, 0};

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int currentState = current[0];
            int flips = current[1];

            if (currentState == 0) {
                return flips;
            }

            for (int r = 0; r < m; r++) {
                for (int c = 0; c < n; c++) {
                    int nextState = currentState;

                    for (int i = 0; i < 5; i++) {
                        int nr = r + dr[i];
                        int nc = c + dc[i];

                        if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                            int bitIndex = nr * n + nc;
                            nextState ^= (1 << bitIndex);
                        }
                    }

                    if (!visited.contains(nextState)) {
                        visited.add(nextState);
                        queue.offer(new int[]{nextState, flips + 1});
                    }
                }
            }
        }

        return -1;
    }
}