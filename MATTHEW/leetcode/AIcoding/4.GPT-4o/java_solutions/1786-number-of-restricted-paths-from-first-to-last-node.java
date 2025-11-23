import java.util.*;

public class Solution {
    public int countRestrictedPaths(int n, int[][] edges) {
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i <= n; i++) graph.add(new ArrayList<>());

        for (int[] edge : edges) {
            graph.get(edge[0]).add(new int[]{edge[1], edge[2]});
            graph.get(edge[1]).add(new int[]{edge[0], edge[2]});
        }

        int[] dist = new int[n + 1];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[n] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[1]));
        pq.offer(new int[]{n, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int node = curr[0];
            int d = curr[1];

            if (d > dist[node]) continue;

            for (int[] next : graph.get(node)) {
                int nextNode = next[0];
                int weight = next[1];
                if (dist[node] + weight < dist[nextNode]) {
                    dist[nextNode] = dist[node] + weight;
                    pq.offer(new int[]{nextNode, dist[nextNode]});
                }
            }
        }

        long mod = 1000000007;
        long[] dp = new long[n + 1];
        dp[1] = 1;

        Arrays.sort(edges, Comparator.comparingInt(a -> a[2]));

        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            if (dist[u] > dist[v]) {
                dp[u] = (dp[u] + dp[v]) % mod;
            } else {
                dp[v] = (dp[v] + dp[u]) % mod;
            }
        }

        return (int) dp[n];
    }
}