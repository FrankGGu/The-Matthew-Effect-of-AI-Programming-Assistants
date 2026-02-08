class Solution {
    private int[] parent;
    private int[] size;

    public int[] shortestDistance(int n, int[][] roads, int[][] queries) {
        parent = new int[n + 1];
        size = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            parent[i] = i;
            size[i] = 1;
        }

        for (int[] road : roads) {
            union(road[0], road[1]);
        }

        int[] res = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int u = queries[i][0];
            int v = queries[i][1];
            if (find(u) != find(v)) {
                res[i] = -1;
            } else {
                res[i] = bfs(n, roads, u, v);
            }
        }
        return res;
    }

    private int bfs(int n, int[][] roads, int start, int end) {
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] road : roads) {
            int u = road[0];
            int v = road[1];
            int w = road[2];
            graph.get(u).add(new int[]{v, w});
            graph.get(v).add(new int[]{u, w});
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        pq.offer(new int[]{start, 0});
        int[] dist = new int[n + 1];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[start] = 0;

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int node = curr[0];
            int d = curr[1];
            if (node == end) {
                return d;
            }
            if (d > dist[node]) {
                continue;
            }
            for (int[] neighbor : graph.get(node)) {
                int next = neighbor[0];
                int w = neighbor[1];
                if (dist[next] > d + w) {
                    dist[next] = d + w;
                    pq.offer(new int[]{next, dist[next]});
                }
            }
        }
        return -1;
    }

    private int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    private void union(int x, int y) {
        int fx = find(x);
        int fy = find(y);
        if (fx != fy) {
            if (size[fx] < size[fy]) {
                parent[fx] = fy;
                size[fy] += size[fx];
            } else {
                parent[fy] = fx;
                size[fx] += size[fy];
            }
        }
    }
}