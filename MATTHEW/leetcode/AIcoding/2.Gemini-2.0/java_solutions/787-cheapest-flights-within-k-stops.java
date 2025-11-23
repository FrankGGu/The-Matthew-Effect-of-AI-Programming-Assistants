import java.util.*;

class Solution {
    public int findCheapestPrice(int n, int[][] flights, int src, int dst, int k) {
        Map<Integer, List<int[]>> adj = new HashMap<>();
        for (int[] flight : flights) {
            adj.computeIfAbsent(flight[0], key -> new ArrayList<>()).add(new int[]{flight[1], flight[2]});
        }

        int[] dist = new int[n];
        Arrays.fill(dist, Integer.MAX_VALUE);
        dist[src] = 0;

        Queue<int[]> queue = new LinkedList<>();
        queue.offer(new int[]{src, 0, -1}); // {city, cost, stops}

        while (!queue.isEmpty()) {
            int[] curr = queue.poll();
            int city = curr[0];
            int cost = curr[1];
            int stops = curr[2];

            if (stops > k) continue;

            if (!adj.containsKey(city)) continue;

            for (int[] neighbor : adj.get(city)) {
                int nextCity = neighbor[0];
                int nextCost = neighbor[1];

                if (cost + nextCost < dist[nextCity]) {
                    dist[nextCity] = cost + nextCost;
                    queue.offer(new int[]{nextCity, dist[nextCity], stops + 1});
                }
            }
        }

        return dist[dst] == Integer.MAX_VALUE ? -1 : dist[dst];
    }
}