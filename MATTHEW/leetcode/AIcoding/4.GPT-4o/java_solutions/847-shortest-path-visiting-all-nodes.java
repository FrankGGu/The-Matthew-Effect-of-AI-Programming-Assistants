import java.util.*;

class Solution {
    public int shortestPathLength(int[][] graph) {
        int n = graph.length;
        if (n == 1) return 0;

        int targetState = (1 << n) - 1;
        Queue<int[]> queue = new LinkedList<>();
        boolean[][] visited = new boolean[n][1 << n];

        for (int i = 0; i < n; i++) {
            queue.offer(new int[]{i, 1 << i});
            visited[i][1 << i] = true;
        }

        int steps = 0;
        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                int[] curr = queue.poll();
                int node = curr[0], state = curr[1];

                if (state == targetState) return steps;

                for (int neighbor : graph[node]) {
                    int newState = state | (1 << neighbor);
                    if (!visited[neighbor][newState]) {
                        visited[neighbor][newState] = true;
                        queue.offer(new int[]{neighbor, newState});
                    }
                }
            }
            steps++;
        }
        return -1;
    }
}