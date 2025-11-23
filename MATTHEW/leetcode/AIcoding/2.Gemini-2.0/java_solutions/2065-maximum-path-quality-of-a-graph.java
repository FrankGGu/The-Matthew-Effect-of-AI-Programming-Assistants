import java.util.*;

class Solution {
    public int maximalPathQuality(int[] values, int[][] edges, int maxTime) {
        int n = values.length;
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int cost = edge[2];
            adj.get(u).add(new int[]{v, cost});
            adj.get(v).add(new int[]{u, cost});
        }

        int[] visited = new int[n];
        visited[0] = 1;
        return dfs(0, values, adj, maxTime, values[0], visited);
    }

    private int dfs(int u, int[] values, List<List<int[]>> adj, int time, int quality, int[] visited) {
        int maxQuality = (u == 0) ? quality : 0;

        for (int[] neighbor : adj.get(u)) {
            int v = neighbor[0];
            int cost = neighbor[1];

            if (time - cost >= 0) {
                if (visited[v] == 0) {
                    visited[v] = 1;
                    maxQuality = Math.max(maxQuality, dfs(v, values, adj, time - cost, quality + values[v], visited));
                    visited[v] = 0;
                } else {
                    maxQuality = Math.max(maxQuality, dfs(v, values, adj, time - cost, quality, visited));
                }
            }
        }

        return maxQuality;
    }
}