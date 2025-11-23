import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

class Solution {
    public int findShortestCycle(int n, int[][] edges) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int minCycle = Integer.MAX_VALUE;

        for (int startNode = 0; startNode < n; startNode++) {
            int[] dist = new int[n];
            int[] parent = new int[n];
            Arrays.fill(dist, -1);
            Arrays.fill(parent, -1);

            Queue<Integer> q = new LinkedList<>();
            q.offer(startNode);
            dist[startNode] = 0;

            while (!q.isEmpty()) {
                int u = q.poll();

                for (int v : adj.get(u)) {
                    if (dist[v] == -1) {
                        dist[v] = dist[u] + 1;
                        parent[v] = u;
                        q.offer(v);
                    } else if (parent[u] != v && parent[v] != u) {
                        minCycle = Math.min(minCycle, dist[u] + dist[v] + 1);
                    }
                }
            }
        }

        return (minCycle == Integer.MAX_VALUE) ? -1 : minCycle;
    }
}