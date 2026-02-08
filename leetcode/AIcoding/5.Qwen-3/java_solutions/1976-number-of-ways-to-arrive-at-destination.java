public class Solution {

import java.util.*;

public class Solution {
    public int countPaths(int n, int[][] roads) {
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] road : roads) {
            adj.get(road[0]).add(new int[]{road[1], road[2]});
        }

        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[0] = 0;

        int[] ways = new int[n];
        ways[0] = 1;

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        pq.offer(new int[]{0, 0});

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int node = curr[0];
            int d = curr[1];

            if (d > dist[node]) continue;

            for (int[] neighbor : adj.get(node)) {
                int nextNode = neighbor[0];
                int nextDist = neighbor[1];

                if (dist[nextNode] > d + nextDist) {
                    dist[nextNode] = d + nextDist;
                    ways[nextNode] = ways[node];
                    pq.offer(new int[]{nextNode, dist[nextNode]});
                } else if (dist[nextNode] == d + nextDist) {
                    ways[nextNode] = (ways[nextNode] + ways[node]) % (1000000007);
                }
            }
        }

        return ways[n - 1];
    }
}
}