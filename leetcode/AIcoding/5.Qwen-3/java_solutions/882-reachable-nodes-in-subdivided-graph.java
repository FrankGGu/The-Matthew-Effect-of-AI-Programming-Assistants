public class Solution {

import java.util.*;

public class Solution {
    public int reachableNodes(int[][] edges, int maxMoves, int n) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], cnt = edge[2];
            graph.putIfAbsent(u, new ArrayList<>());
            graph.putIfAbsent(v, new ArrayList<>());
            graph.get(u).add(new int[]{v, cnt});
            graph.get(v).add(new int[]{u, cnt});
        }

        int[] dist = new int[n];
        Arrays.fill(dist, -1);
        dist[0] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        pq.offer(new int[]{0, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int node = curr[0], d = curr[1];
            if (d > dist[node]) continue;
            for (int[] next : graph.getOrDefault(node, new ArrayList<>())) {
                int neighbor = next[0], weight = next[1];
                if (dist[neighbor] == -1 || d + weight < dist[neighbor]) {
                    dist[neighbor] = d + weight;
                    pq.offer(new int[]{neighbor, dist[neighbor]});
                }
            }
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            if (dist[i] <= maxMoves) result++;
        }

        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], cnt = edge[2];
            int a = dist[u], b = dist[v];
            if (a == -1 && b == -1) continue;
            if (a == -1) result += Math.min(b, maxMoves);
            else if (b == -1) result += Math.min(a, maxMoves);
            else result += Math.min(a + b, maxMoves);
        }

        return result;
    }
}
}