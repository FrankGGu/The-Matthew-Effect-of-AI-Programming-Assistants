public class Solution {

import java.util.*;

public class Solution {
    public int countRestrictedPaths(int[][] edges, int n, int k) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph.computeIfAbsent(u, key -> new ArrayList<>()).add(new int[]{v, w});
            graph.computeIfAbsent(v, key -> new ArrayList<>()).add(new int[]{u, w});
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        int[] dist = new int[n + 1];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[1] = 0;
        pq.offer(new int[]{1, 0});

        while (!pq.isEmpty()) {
            int[] node = pq.poll();
            int u = node[0], d = node[1];
            if (d > dist[u]) continue;
            for (int[] neighbor : graph.getOrDefault(u, new ArrayList<>())) {
                int v = neighbor[0], weight = neighbor[1];
                if (dist[v] > dist[u] + weight) {
                    dist[v] = dist[u] + weight;
                    pq.offer(new int[]{v, dist[v]});
                }
            }
        }

        List<Integer> nodes = new ArrayList<>();
        for (int i = 1; i <= n; i++) {
            nodes.add(i);
        }
        nodes.sort((a, b) -> dist[a] - dist[b]);

        int[][] dp = new int[n + 1][k + 1];
        dp[1][0] = 1;

        for (int i = 0; i < nodes.size(); i++) {
            int u = nodes.get(i);
            for (int j = 0; j <= k; j++) {
                for (int[] neighbor : graph.getOrDefault(u, new ArrayList<>())) {
                    int v = neighbor[0];
                    if (dist[v] > dist[u]) {
                        if (j + 1 <= k) {
                            dp[v][j + 1] += dp[u][j];
                            dp[v][j + 1] %= 1000000007;
                        }
                    }
                }
            }
        }

        return dp[n][k];
    }
}
}