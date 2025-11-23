class Solution {
    public int collectTheCoins(int[] coins, int[][] edges) {
        int n = coins.length;
        Set<Integer>[] adj = new Set[n];
        for (int i = 0; i < n; i++) {
            adj[i] = new HashSet<>();
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            adj[u].add(v);
            adj[v].add(u);
        }

        Queue<Integer> q = new LinkedList<>();
        for (int i = 0; i < n; i++) {
            if (adj[i].size() == 1 && coins[i] == 0) {
                q.offer(i);
            }
        }

        while (!q.isEmpty()) {
            int u = q.poll();
            if (adj[u].isEmpty()) continue;
            int v = adj[u].iterator().next();
            adj[u].remove(v);
            adj[v].remove(u);
            if (adj[v].size() == 1 && coins[v] == 0) {
                q.offer(v);
            }
        }

        int[] dist = new int[n];
        Arrays.fill(dist, -1);
        q.clear();
        for (int i = 0; i < n; i++) {
            if (adj[i].size() == 1 && coins[i] == 1) {
                q.offer(i);
                dist[i] = 0;
            }
        }

        while (!q.isEmpty()) {
            int u = q.poll();
            for (int v : adj[u]) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    q.offer(v);
                }
            }
        }

        int res = 0;
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            if (dist[u] >= 2 && dist[v] >= 2) {
                res += 2;
            }
        }
        return res;
    }
}