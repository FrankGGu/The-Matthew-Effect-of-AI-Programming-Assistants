import java.util.*;

class Solution {
    private Map<String, PriorityQueue<String>> graph = new HashMap<>();
    private List<String> itinerary = new LinkedList<>();

    public List<String> findItinerary(List<List<String>> tickets) {
        for (List<String> ticket : tickets) {
            String from = ticket.get(0);
            String to = ticket.get(1);
            graph.computeIfAbsent(from, k -> new PriorityQueue<>()).offer(to);
        }
        dfs("JFK");
        return itinerary;
    }

    private void dfs(String airport) {
        PriorityQueue<String> destinations = graph.get(airport);
        while (destinations != null && !destinations.isEmpty()) {
            String nextAirport = destinations.poll();
            dfs(nextAirport);
        }
        itinerary.add(0, airport);
    }
}