import java.util.*;

class Solution {
    public int reachableNodes(int n, int[][] edges, int maxMoves) {
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            adj.get(u).add(new int[]{v, w});
            adj.get(v).add(new int[]{u, w});
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));
        pq.offer(new int[]{0, 0}); // {distance, node}
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[0] = 0;

        Map<String, Integer> usedEdges = new HashMap<>();
        int reachableNodes = 0;

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int d = curr[0], u = curr[1];

            if (d > dist[u]) continue;

            reachableNodes++;

            for (int[] neighbor : adj.get(u)) {
                int v = neighbor[0], w = neighbor[1];
                int newDist = d + w + 1;

                String edgeKey = Math.min(u, v) + "-" + Math.max(u, v);
                int usedNodes = Math.min(w, maxMoves - d);
                usedEdges.put(edgeKey, usedEdges.getOrDefault(edgeKey, 0) + usedNodes);

                if (newDist < dist[v] && d + w + 1 <= maxMoves) {
                    dist[v] = d + w + 1;
                    pq.offer(new int[]{dist[v], v});
                }
            }
        }

        int additionalNodes = 0;
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            String edgeKey = Math.min(u, v) + "-" + Math.max(u, v);
            int usedNodes = usedEdges.getOrDefault(edgeKey, 0);
            additionalNodes += Math.min(w, usedNodes);
        }

        return reachableNodes + additionalNodes;
    }
}