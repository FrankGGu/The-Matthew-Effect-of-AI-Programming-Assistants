import java.util.*;

class Solution {
    public int countRestrictedPaths(int n, int[][] edges) {
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            adj.get(u).add(new int[]{v, w});
            adj.get(v).add(new int[]{u, w});
        }

        int[] dist = new int[n + 1];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[n] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));
        pq.offer(new int[]{0, n});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int d = curr[0], u = curr[1];

            if (d > dist[u]) continue;

            for (int[] neighbor : adj.get(u)) {
                int v = neighbor[0], w = neighbor[1];
                if (dist[u] + w < dist[v]) {
                    dist[v] = dist[u] + w;
                    pq.offer(new int[]{dist[v], v});
                }
            }
        }

        int[] dp = new int[n + 1];
        dp[n] = 1;
        boolean[] visited = new boolean[n + 1];

        return dfs(1, n, adj, dist, dp, visited);
    }

    private int dfs(int u, int n, List<List<int[]>> adj, int[] dist, int[] dp, boolean[] visited) {
        if (dp[u] != 0) return dp[u];
        if (visited[u]) return 0;

        visited[u] = true;
        long count = 0;
        for (int[] neighbor : adj.get(u)) {
            int v = neighbor[0];
            if (dist[u] > dist[v]) {
                count = (count + dfs(v, n, adj, dist, dp, visited)) % 1000000007;
            }
        }
        visited[u] = false;
        dp[u] = (int) count;
        return dp[u];
    }
}