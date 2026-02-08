class Solution {
    public long minimumWeight(int n, int[][] edges, int src1, int src2, int dest) {
        List<List<int[]>> graph = new ArrayList<>();
        List<List<int[]>> reverseGraph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
            reverseGraph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int from = edge[0];
            int to = edge[1];
            int weight = edge[2];
            graph.get(from).add(new int[]{to, weight});
            reverseGraph.get(to).add(new int[]{from, weight});
        }

        long[] dist1 = dijkstra(graph, src1, n);
        long[] dist2 = dijkstra(graph, src2, n);
        long[] distDest = dijkstra(reverseGraph, dest, n);

        long minWeight = Long.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            if (dist1[i] != Long.MAX_VALUE && dist2[i] != Long.MAX_VALUE && distDest[i] != Long.MAX_VALUE) {
                long total = dist1[i] + dist2[i] + distDest[i];
                if (total < minWeight) {
                    minWeight = total;
                }
            }
        }

        return minWeight == Long.MAX_VALUE ? -1 : minWeight;
    }

    private long[] dijkstra(List<List<int[]>> graph, int start, int n) {
        long[] dist = new long[n];
        Arrays.fill(dist, Long.MAX_VALUE);
        dist[start] = 0;
        PriorityQueue<long[]> pq = new PriorityQueue<>((a, b) -> Long.compare(a[1], b[1]));
        pq.offer(new long[]{start, 0});

        while (!pq.isEmpty()) {
            long[] curr = pq.poll();
            int node = (int) curr[0];
            long distance = curr[1];
            if (distance > dist[node]) {
                continue;
            }
            for (int[] neighbor : graph.get(node)) {
                int next = neighbor[0];
                long weight = neighbor[1];
                if (dist[next] > dist[node] + weight) {
                    dist[next] = dist[node] + weight;
                    pq.offer(new long[]{next, dist[next]});
                }
            }
        }
        return dist;
    }
}