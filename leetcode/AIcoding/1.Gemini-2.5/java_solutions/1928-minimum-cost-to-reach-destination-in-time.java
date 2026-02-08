import java.util.*;

class Solution {
    public int minCost(int n, int[][] edges, int maxTime) {
        List<List<int[]>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int t = edge[2];
            int c = edge[3];
            adj.get(u).add(new int[]{v, t, c});
            adj.get(v).add(new int[]{u, t, c}); // Undirected graph
        }

        // minCost[city][time] stores the minimum cost to reach 'city' at 'time'
        // Initialize with infinity (a large value).
        int[][] minCost = new int[n][maxTime + 1];
        for (int i = 0; i < n; i++) {
            Arrays.fill(minCost[i], Integer.MAX_VALUE);
        }

        // PriorityQueue stores {cost, time, city}
        // Prioritize by cost, then by time (for tie-breaking, though not strictly necessary for correctness,
        // it can help prune states faster).
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> {
            if (a[0] != b[0]) return a[0] - b[0]; // Compare costs
            return a[1] - b[1]; // Compare times
        });

        // Start from city 0 at time 0 with cost 0
        minCost[0][0] = 0;
        pq.offer(new int[]{0, 0, 0}); // {cost, time, city}

        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int currentCost = current[0];
            int currentTime = current[1];
            int currentCity = current[2];

            // If we've already found a cheaper way to reach currentCity at currentTime, skip
            if (currentCost > minCost[currentCity][currentTime]) {
                continue;
            }

            // Explore neighbors
            for (int[] neighborEdge : adj.get(currentCity)) {
                int neighbor = neighborEdge[0];
                int travelTime = neighborEdge[1];
                int travelCost = neighborEdge[2];

                int newTime = currentTime + travelTime;
                int newCost = currentCost + travelCost;

                // Check if new path is within maxTime and is cheaper
                if (newTime <= maxTime && newCost < minCost[neighbor][newTime]) {
                    minCost[neighbor][newTime] = newCost;
                    pq.offer(new int[]{newCost, newTime, neighbor});
                }
            }
        }

        // After Dijkstra, find the minimum cost to reach city n-1 within maxTime
        int result = Integer.MAX_VALUE;
        for (int t = 0; t <= maxTime; t++) {
            result = Math.min(result, minCost[n - 1][t]);
        }

        return (result == Integer.MAX_VALUE) ? -1 : result;
    }
}