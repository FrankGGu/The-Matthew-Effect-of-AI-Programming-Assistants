import java.util.*;

class Solution {
    public int findShortestCycle(int n, int[][] edges) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        int minCycle = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            int[] dist = new int[n];
            Arrays.fill(dist, -1);
            int[] parent = new int[n];
            Arrays.fill(parent, -1);

            Queue<Integer> q = new LinkedList<>();

            q.offer(i);
            dist[i] = 0;

            while (!q.isEmpty()) {
                int u = q.poll();

                for (int v : adj.get(u)) {
                    if (dist[v] == -1) {
                        dist[v] = dist[u] + 1;
                        parent[v] = u;
                        q.offer(v);
                    } else if (v != parent[u]) {
                        minCycle = Math.min(minCycle, dist[u] + dist[v] + 1);
                    }
                }
            }
        }

        return minCycle == Integer.MAX_VALUE ? -1 : minCycle;
    }
}