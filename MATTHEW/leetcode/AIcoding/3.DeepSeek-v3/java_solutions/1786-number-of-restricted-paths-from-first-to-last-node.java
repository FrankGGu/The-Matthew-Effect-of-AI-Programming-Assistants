class Solution {
    public int countRestrictedPaths(int n, int[][] edges) {
        final int MOD = 1_000_000_007;
        List<int[]>[] graph = new ArrayList[n + 1];
        for (int i = 1; i <= n; i++) {
            graph[i] = new ArrayList<>();
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph[u].add(new int[]{v, w});
            graph[v].add(new int[]{u, w});
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        int[] dist = new int[n + 1];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[n] = 0;
        pq.offer(new int[]{n, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int u = curr[0], d = curr[1];
            if (d > dist[u]) continue;
            for (int[] neighbor : graph[u]) {
                int v = neighbor[0], w = neighbor[1];
                if (dist[v] > dist[u] + w) {
                    dist[v] = dist[u] + w;
                    pq.offer(new int[]{v, dist[v]});
                }
            }
        }

        Integer[] memo = new Integer[n + 1];
        return dfs(1, n, dist, graph, memo, MOD);
    }

    private int dfs(int u, int n, int[] dist, List<int[]>[] graph, Integer[] memo, int MOD) {
        if (u == n) return 1;
        if (memo[u] != null) return memo[u];
        int res = 0;
        for (int[] neighbor : graph[u]) {
            int v = neighbor[0];
            if (dist[u] > dist[v]) {
                res = (res + dfs(v, n, dist, graph, memo, MOD)) % MOD;
            }
        }
        memo[u] = res;
        return res;
    }
}