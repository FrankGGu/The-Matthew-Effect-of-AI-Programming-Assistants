class Solution {
    public long minimumWeight(int n, int[][] edges, int src1, int src2, int dest) {
        List<List<int[]>> graph = new ArrayList<>();
        List<List<int[]>> reverseGraph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
            reverseGraph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph.get(u).add(new int[]{v, w});
            reverseGraph.get(v).add(new int[]{u, w});
        }

        long[] dist1 = dijkstra(graph, src1, n);
        long[] dist2 = dijkstra(graph, src2, n);
        long[] distDest = dijkstra(reverseGraph, dest, n);

        long res = Long.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            if (dist1[i] != Long.MAX_VALUE && dist2[i] != Long.MAX_VALUE && distDest[i] != Long.MAX_VALUE) {
                res = Math.min(res, dist1[i] + dist2[i] + distDest[i]);
            }
        }

        return res == Long.MAX_VALUE ? -1 : res;
    }

    private long[] dijkstra(List<List<int[]>> graph, int start, int n) {
        long[] dist = new long[n];
        Arrays.fill(dist, Long.MAX_VALUE);
        dist[start] = 0;
        PriorityQueue<long[]> pq = new PriorityQueue<>((a, b) -> Long.compare(a[1], b[1]));
        pq.offer(new long[]{start, 0});

        while (!pq.isEmpty()) {
            long[] curr = pq.poll();
            int u = (int) curr[0];
            long d = curr[1];
            if (d > dist[u]) continue;
            for (int[] neighbor : graph.get(u)) {
                int v = neighbor[0];
                int w = neighbor[1];
                if (dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    pq.offer(new long[]{v, dist[v]});
                }
            }
        }
        return dist;
    }
}