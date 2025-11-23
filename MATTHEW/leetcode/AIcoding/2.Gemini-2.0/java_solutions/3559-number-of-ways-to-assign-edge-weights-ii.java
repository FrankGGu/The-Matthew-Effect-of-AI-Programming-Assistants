import java.util.*;

class Solution {
    public int numberOfWays(int n, int[][] edges, int discount) {
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0] - 1;
            int v = edge[1] - 1;
            int w = edge[2];
            adj.get(u).add(new int[]{v, w});
            adj.get(v).add(new int[]{u, w});
        }

        long totalWays = 0;
        for (int startNode = 0; startNode < n; startNode++) {
            for (int endNode = 0; endNode < n; endNode++) {
                if (startNode == endNode) continue;

                PriorityQueue<long[]> pq = new PriorityQueue<>(Comparator.comparingLong(a -> a[0]));
                pq.offer(new long[]{0, startNode, 1});

                while (!pq.isEmpty()) {
                    long[] curr = pq.poll();
                    long dist = curr[0];
                    int node = (int) curr[1];
                    long ways = curr[2];

                    if (node == endNode) {
                        totalWays = (totalWays + ways) % 1000000007;
                        continue;
                    }

                    for (int[] neighborInfo : adj.get(node)) {
                        int neighbor = neighborInfo[0];
                        int weight = neighborInfo[1];
                        long newDist = dist + weight;
                        if (weight == 1) {
                            pq.offer(new long[]{newDist, neighbor, ways});
                        } else {
                            pq.offer(new long[]{newDist * (100 - discount) / 100, neighbor, ways});
                        }
                    }
                }
            }
        }

        return (int)(totalWays % 1000000007);
    }
}