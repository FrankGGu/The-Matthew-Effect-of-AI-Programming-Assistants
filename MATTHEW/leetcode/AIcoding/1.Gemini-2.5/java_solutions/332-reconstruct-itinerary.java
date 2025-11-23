import java.util.*;

class Solution {
    Map<String, PriorityQueue<String>> adj;
    LinkedList<String> result;

    public List<String> findItinerary(List<List<String>> tickets) {
        adj = new HashMap<>();
        result = new LinkedList<>();

        for (List<String> ticket : tickets) {
            String from = ticket.get(0);
            String to = ticket.get(1);
            adj.computeIfAbsent(from, k -> new PriorityQueue<>()).add(to);
        }

        dfs("JFK");

        return result;
    }

    private void dfs(String airport) {
        PriorityQueue<String> destinations = adj.get(airport);
        while (destinations != null && !destinations.isEmpty()) {
            String nextAirport = destinations.poll();
            dfs(nextAirport);
        }
        result.addFirst(airport);
    }
}