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
        for (int i = 0; i < queries.length; i++) {
            int[] query = queries[i];
            int u = query[0];
            int v = query[1];
            graph.get(u).add(v);
            int distance = bfs(n, graph);
            result[i] = distance;
        }
        return result;
    }

    private int bfs(int n, List<List<Integer>> graph) {
        boolean[] visited = new boolean[n];
        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{0, 0});
        visited[0] = true;

        while (!queue.isEmpty()) {
            int[] node = queue.poll();
            int current = node[0];
            int dist = node[1];
            if (current == n - 1) {
                return dist;
            }
            for (int neighbor : graph.get(current)) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    queue.offer(new int[]{neighbor, dist + 1});
                }
            }
        }
        return -1;
    }
}
}