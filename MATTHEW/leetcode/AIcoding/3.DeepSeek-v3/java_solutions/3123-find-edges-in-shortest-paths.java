class Solution {
    public boolean[] findAnswer(int n, int[][] edges) {
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int i = 0; i < edges.length; i++) {
            int u = edges[i][0];
            int v = edges[i][1];
            int w = edges[i][2];
            graph.get(u).add(new int[]{v, w, i});
            graph.get(v).add(new int[]{u, w, i});
        }

        int[] distFromStart = dijkstra(0, graph, n);
        int[] distFromEnd = dijkstra(n - 1, graph, n);

        boolean[] res = new boolean[edges.length];
        if (distFromStart[n - 1] == Integer.MAX_VALUE) {
            return res;
        }

        int totalDist = distFromStart[n - 1];
        for (int u = 0; u < n; u++) {
            for (int[] edge : graph.get(u)) {
                int v = edge[0];
                int w = edge[1];
                int idx = edge[2];
                if (distFromStart[u] != Integer.MAX_VALUE && distFromEnd[v] != Integer.MAX_VALUE &&
                    distFromStart[u] + w + distFromEnd[v] == totalDist) {
                    res[idx] = true;
                }
            }
        }
        return res;
    }

    private int[] dijkstra(int start, List<List<int[]>> graph, int n) {
        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[start] = 0;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        pq.offer(new int[]{start, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int u = curr[0];
            int d = curr[1];
            if (d > dist[u]) {
                continue;
            }
            for (int[] edge : graph.get(u)) {
                int v = edge[0];
                int w = edge[1];
                if (dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    pq.offer(new int[]{v, dist[v]});
                }
            }
        }
        return dist;
    }
}