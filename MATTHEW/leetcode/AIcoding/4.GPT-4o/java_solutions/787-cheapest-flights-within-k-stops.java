import java.util.*;

public class Solution {
    class Flight {
        int city, cost, stops;
        Flight(int city, int cost, int stops) {
            this.city = city;
            this.cost = cost;
            this.stops = stops;
        }
    }

    public int findCheapestPrice(int n, int[][] flights, int src, int dst, int k) {
        Map<Integer, List<Flight>> graph = new HashMap<>();
        for (int[] flight : flights) {
            graph.computeIfAbsent(flight[0], x -> new ArrayList<>()).add(new Flight(flight[1], flight[2], 0));
        }

        PriorityQueue<Flight> pq = new PriorityQueue<>(Comparator.comparingInt(f -> f.cost));
        pq.offer(new Flight(src, 0, 0));
        int minCost = Integer.MAX_VALUE;

        while (!pq.isEmpty()) {
            Flight current = pq.poll();
            if (current.city == dst) {
                minCost = Math.min(minCost, current.cost);
                continue;
            }
            if (current.stops > k) continue;

            List<Flight> nextFlights = graph.getOrDefault(current.city, new ArrayList<>());
            for (Flight next : nextFlights) {
                pq.offer(new Flight(next.city, current.cost + next.cost, current.stops + 1));
            }
        }

        return minCost == Integer.MAX_VALUE ? -1 : minCost;
    }
}