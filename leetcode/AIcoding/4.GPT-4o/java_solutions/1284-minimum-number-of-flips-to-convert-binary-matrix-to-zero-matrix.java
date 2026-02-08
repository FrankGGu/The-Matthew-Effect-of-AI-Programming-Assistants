public class Solution {
    public int minFlips(int[][] mat) {
        int m = mat.length, n = mat[0].length;
        int target = 0;
        int start = 0;
        for (int[] row : mat) {
            for (int num : row) {
                target = (target << 1) | num;
            }
        }
        return bfs(start, target, m, n);
    }

    private int bfs(int start, int target, int m, int n) {
        Set<Integer> visited = new HashSet<>();
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{start, 0});
        visited.add(start);

        while (!queue.isEmpty()) {
            int[] cur = queue.poll();
            int state = cur[0], flips = cur[1];
            if (state == target) return flips;

            for (int i = 0; i < m; i++) {
                for (int j = 0; j < n; j++) {
                    int nextState = state ^ (1 << (i * n + j));
                    if (i > 0) nextState ^= (1 << ((i - 1) * n + j));
                    if (i < m - 1) nextState ^= (1 << ((i + 1) * n + j));
                    if (j > 0) nextState ^= (1 << (i * n + j - 1));
                    if (j < n - 1) nextState ^= (1 << (i * n + j + 1));
                    if (visited.add(nextState)) {
                        queue.offer(new int[]{nextState, flips + 1});
                    }
                }
            }
        }
        return -1;
    }
}