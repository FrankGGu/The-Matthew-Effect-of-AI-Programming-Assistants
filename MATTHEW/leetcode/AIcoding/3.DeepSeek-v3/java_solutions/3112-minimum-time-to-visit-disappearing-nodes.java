class Solution {
    public int[] minimumTime(int n, int[][] edges, int[] disappear) {
        List<int[]>[] graph = new List[n];
        for (int i = 0; i < n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph[u].add(new int[]{v, w});
            graph[v].add(new int[]{u, w});
        }

        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[0] = 0;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        pq.offer(new int[]{0, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int u = curr[0], time = curr[1];
            if (time > dist[u]) continue;
            for (int[] neighbor : graph[u]) {
                int v = neighbor[0], w = neighbor[1];
                int newTime = time + w;
                if (newTime < dist[v] && newTime < disappear[v]) {
                    dist[v] = newTime;
                    pq.offer(new int[]{v, newTime});
                }
            }
        }

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = dist[i] == Integer.MAX_VALUE ? -1 : dist[i];
        }
        return result;
    }
}