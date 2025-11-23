public class Solution {

import java.util.*;

public class Solution {
    public int[] shortestDistanceAfterRoadAdditions(int n, int[][] queries) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int i = 0; i < n - 1; i++) {
            graph.get(i).add(i + 1);
        }

        int[] result = new int[queries.length];
        int idx = 0;

        for (int[] query : queries) {
            int u = query[0];
            int v = query[1];
            graph.get(u).add(v);
            int[] dist = bfs(n, graph);
            result[idx++] = dist[n - 1];
        }

        return result;
    }

    private int[] bfs(int n, List<List<Integer>> graph) {
        int[] dist = new int[n];
        Arrays.fill(dist, -1);
        Queue<Integer> queue = new LinkedList<>();
        queue.add(0);
        dist[0] = 0;

        while (!queue.isEmpty()) {
            int node = queue.poll();
            for (int neighbor : graph.get(node)) {
                if (dist[neighbor] == -1) {
                    dist[neighbor] = dist[node] + 1;
                    queue.add(neighbor);
                }
            }
        }

        return dist;
    }
}
}