import java.util.*;

class Solution {
    public int reachableNodes(int[][] edges, int maxMoves, int n) {
        Map<Integer, Map<Integer, Integer>> graph = new HashMap<>();
        for (int[] edge : edges) {
            graph.putIfAbsent(edge[0], new HashMap<>());
            graph.putIfAbsent(edge[1], new HashMap<>());
            graph.get(edge[0]).put(edge[1], edge[2]);
            graph.get(edge[1]).put(edge[0], edge[2]);
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[]{0, 0});
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[0] = 0;

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int u = curr[0], d = curr[1];
            if (d > dist[u]) continue;

            for (Map.Entry<Integer, Integer> entry : graph.getOrDefault(u, new HashMap<>()).entrySet()) {
                int v = entry.getKey(), length = entry.getValue();
                int newDist = d + length + 1;
                if (newDist <= maxMoves && newDist < dist[v]) {
                    dist[v] = newDist;
                    pq.offer(new int[]{v, newDist});
                }
            }
        }

        boolean[] visited = new boolean[n];
        int reachable = 0;
        for (int i = 0; i < n; i++) {
            if (dist[i] <= maxMoves) {
                reachable++;
                visited[i] = true;
            }
        }

        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], length = edge[2];
            int reachableInEdge = 0;
            if (visited[u] && !visited[v]) {
                reachableInEdge = Math.max(0, maxMoves - dist[u]);
            } else if (visited[v] && !visited[u]) {
                reachableInEdge = Math.max(0, maxMoves - dist[v]);
            }
            reachable += Math.min(length, reachableInEdge);
        }

        return reachable;
    }
}