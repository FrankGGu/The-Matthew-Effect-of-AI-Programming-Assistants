import java.util.LinkedList;
import java.util.Queue;

class Solution {
    public int shortestPathLength(int[][] graph) {
        int n = graph.length;
        if (n == 1) {
            return 0;
        }

        Queue<int[]> queue = new LinkedList<>();
        boolean[][] visited = new boolean[n][1 << n];

        for (int i = 0; i < n; i++) {
            queue.offer(new int[]{i, 1 << i, 0});
            visited[i][1 << i] = true;
        }

        int allNodesVisitedMask = (1 << n) - 1;

        while (!queue.isEmpty()) {
            int[] current = queue.poll();
            int u = current[0];
            int mask = current[1];
            int dist = current[2];

            if (mask == allNodesVisitedMask) {
                return dist;
            }

            for (int v : graph[u]) {
                int newMask = mask | (1 << v);
                if (!visited[v][newMask]) {
                    visited[v][newMask] = true;
                    queue.offer(new int[]{v, newMask, dist + 1});
                }
            }
        }
        return -1; // Should not be reached based on problem constraints
    }
}