public class Solution {

import java.util.*;

public class Solution {
    public int minCostWalk(int n, int[][] edges, int start, int end, int k) {
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            graph.get(u).add(new int[]{v, w});
            graph.get(v).add(new int[]{u, w});
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));
        pq.offer(new int[]{0, start, 0});

        int[][] dist = new int[n][k + 1];
        for (int i = 0; i < n; i++) {
            Arrays.fill(dist[i], Integer.MAX_VALUE);
        }
        dist[start][0] = 0;

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int cost = curr[0];
            int node = curr[1];
            int steps = curr[2];

            if (node == end) {
                return cost;
            }

            if (steps >= k) {
                continue;
            }

            for (int[] neighbor : graph.get(node)) {
                int nextNode = neighbor[0];
                int weight = neighbor[1];
                if (dist[nextNode][steps + 1] > cost + weight) {
                    dist[nextNode][steps + 1] = cost + weight;
                    pq.offer(new int[]{dist[nextNode][steps + 1], nextNode, steps + 1});
                }
            }
        }

        return -1;
    }
}
}