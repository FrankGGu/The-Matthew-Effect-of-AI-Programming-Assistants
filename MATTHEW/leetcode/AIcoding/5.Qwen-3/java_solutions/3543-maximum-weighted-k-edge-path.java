public class Solution {

import java.util.*;

public class Solution {
    public int maxKWeightedPath(int n, int[][] edges, int k) {
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph.get(u).add(new int[]{v, w});
            graph.get(v).add(new int[]{u, w});
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> b[1] - a[1]);
        boolean[] visited = new boolean[n];
        int result = 0;
        int count = 0;

        pq.offer(new int[]{0, 0});

        while (!pq.isEmpty() && count < k) {
            int[] node = pq.poll();
            int u = node[0], weight = node[1];

            if (visited[u]) continue;
            visited[u] = true;
            result += weight;
            count++;

            for (int[] neighbor : graph.get(u)) {
                int v = neighbor[0], w = neighbor[1];
                if (!visited[v]) {
                    pq.offer(new int[]{v, w});
                }
            }
        }

        return result;
    }
}
}