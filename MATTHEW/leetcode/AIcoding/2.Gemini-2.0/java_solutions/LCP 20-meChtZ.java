import java.util.*;

class Solution {
    public int minCost(int maxTime, int[][] edges, int[] passingFees) {
        int n = passingFees.length;
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int time = edge[2];
            adj.get(u).add(new int[]{v, time});
            adj.get(v).add(new int[]{u, time});
        }

        int[] minTime = new int[n];
        Arrays.fill(minTime, Integer.MAX_VALUE);
        int[] minCost = new int[n];
        Arrays.fill(minCost, Integer.MAX_VALUE);

        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[0])); // {cost, node, time}
        pq.offer(new int[]{passingFees[0], 0, 0});
        minTime[0] = 0;
        minCost[0] = passingFees[0];

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int cost = curr[0];
            int u = curr[1];
            int time = curr[2];

            if (u == n - 1) {
                return cost;
            }

            if (cost > minCost[u] || time > maxTime) continue;

            for (int[] neighbor : adj.get(u)) {
                int v = neighbor[0];
                int t = neighbor[1];

                if (time + t <= maxTime) {
                    int newCost = cost + passingFees[v];
                    if (time + t < minTime[v] || (time + t == minTime[v] && newCost < minCost[v])) {
                        minTime[v] = time + t;
                        minCost[v] = newCost;
                        pq.offer(new int[]{newCost, v, time + t});
                    }
                }
            }
        }

        return -1;
    }
}