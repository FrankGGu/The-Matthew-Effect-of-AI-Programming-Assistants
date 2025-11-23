public class Solution {

import java.util.*;

public class Solution {
    public int maxPathQuality(int[][] edges, int[] isMax, int[][] queries) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.putIfAbsent(edge[0], new ArrayList<>());
            graph.get(edge[0]).add(new int[]{edge[1], edge[2]});
            graph.putIfAbsent(edge[1], new ArrayList<>());
            graph.get(edge[1]).add(new int[]{edge[0], edge[2]});
        }

        int n = isMax.length;
        int[] result = new int[queries.length];
        Arrays.fill(result, -1);

        for (int i = 0; i < queries.length; i++) {
            int u = queries[i][0];
            int v = queries[i][1];
            int maxTime = queries[i][2];

            boolean[] visited = new boolean[n];
            int[] dist = new int[n];
            Arrays.fill(dist, Integer.MAX_VALUE);
            dist[u] = 0;
            PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));
            pq.offer(new int[]{0, u});

            while (!pq.isEmpty()) {
                int[] curr = pq.poll();
                int time = curr[0];
                int node = curr[1];

                if (visited[node]) continue;
                visited[node] = true;

                if (node == v) {
                    int quality = 0;
                    for (int j = 0; j < n; j++) {
                        if (dist[j] <= maxTime) {
                            quality += isMax[j];
                        }
                    }
                    result[i] = quality;
                    break;
                }

                for (int[] neighbor : graph.getOrDefault(node, new ArrayList<>())) {
                    int nextNode = neighbor[0];
                    int cost = neighbor[1];
                    if (time + cost < dist[nextNode]) {
                        dist[nextNode] = time + cost;
                        pq.offer(new int[]{dist[nextNode], nextNode});
                    }
                }
            }
        }

        return result[0];
    }
}
}