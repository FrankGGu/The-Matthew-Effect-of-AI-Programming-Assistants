import java.util.*;

class Solution {
    public int findShortestCycle(int n, int[][] edges) {
        List<List<Integer>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1];
            graph.get(u).add(v);
            graph.get(v).add(u);
        }

        int minCycle = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            int[] dist = new int[n];
            Arrays.fill(dist, -1);
            Queue<Integer> queue = new LinkedList<>();
            queue.offer(i);
            dist[i] = 0;
            while (!queue.isEmpty()) {
                int u = queue.poll();
                for (int v : graph.get(u)) {
                    if (dist[v] == -1) {
                        dist[v] = dist[u] + 1;
                        queue.offer(v);
                    } else if (dist[v] >= dist[u]) {
                        minCycle = Math.min(minCycle, dist[u] + dist[v] + 1);
                    }
                }
            }
        }
        return minCycle == Integer.MAX_VALUE ? -1 : minCycle;
    }
}