public class Solution {

import java.util.*;

public class Solution {
    public int minWeightedSubgraphWithRequiredPaths(int n, int[][] edges, int[] signalSpeed) {
        List<List<int[]>> graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            graph.get(u).add(new int[]{v, w});
            graph.get(v).add(new int[]{u, w});
        }

        int result = 0;
        for (int i = 0; i < signalSpeed.length; i++) {
            int speed = signalSpeed[i];
            if (speed == 0) continue;

            int[] dist = new int[n];
            Arrays.fill(dist, Integer.MAX_VALUE);
            dist[i] = 0;
            PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
            pq.offer(new int[]{i, 0});

            while (!pq.isEmpty()) {
                int[] curr = pq.poll();
                int node = curr[0], d = curr[1];
                if (d > dist[node]) continue;
                for (int[] neighbor : graph.get(node)) {
                    int nextNode = neighbor[0], weight = neighbor[1];
                    if (dist[nextNode] > d + weight) {
                        dist[nextNode] = d + weight;
                        pq.offer(new int[]{nextNode, dist[nextNode]});
                    }
                }
            }

            int total = 0;
            for (int j = 0; j < n; j++) {
                if (dist[j] != Integer.MAX_VALUE) {
                    total += dist[j] * speed;
                }
            }
            result += total;
        }

        return result;
    }
}
}