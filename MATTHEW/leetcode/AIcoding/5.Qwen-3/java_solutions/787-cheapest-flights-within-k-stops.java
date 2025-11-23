public class Solution {

import java.util.*;

public class Solution {
    public int findCheapestPrice(int n, int[][] flights, int src, int dst, int k) {
        Map<Integer, List<int[]>> graph = new HashMap<>();
        for (int[] flight : flights) {
            graph.putIfAbsent(flight[0], new ArrayList<>());
            graph.get(flight[0]).add(new int[]{flight[1], flight[2]});
        }

        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[src] = 0;

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        pq.offer(new int[]{src, 0, 0});

        while (!pq.isEmpty()) {
            int[] node = pq.poll();
            int city = node[0];
            int cost = node[1];
            int stops = node[2];

            if (city == dst) return cost;
            if (stops > k) continue;

            for (int[] neighbor : graph.getOrDefault(city, new ArrayList<>())) {
                int nextCity = neighbor[0];
                int nextCost = cost + neighbor[1];
                if (nextCost < dist[nextCity]) {
                    dist[nextCity] = nextCost;
                    pq.offer(new int[]{nextCity, nextCost, stops + 1});
                }
            }
        }

        return dist[dst] == Integer.MAX_VALUE ? -1 : dist[dst];
    }
}
}