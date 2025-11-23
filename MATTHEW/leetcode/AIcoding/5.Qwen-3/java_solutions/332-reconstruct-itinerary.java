public class Solution {

import java.util.*;

public class Solution {
    public List<String> findItinerary(List<List<String>> tickets) {
        Map<String, PriorityQueue<String>> graph = new HashMap<>();
        for (List<String> ticket : tickets) {
            String src = ticket.get(0);
            String dest = ticket.get(1);
            graph.putIfAbsent(src, new PriorityQueue<>());
            graph.get(src).offer(dest);
        }

        List<String> result = new ArrayList<>();
        dfs("JFK", graph, result);
        Collections.reverse(result);
        return result;
    }

    private void dfs(String node, Map<String, PriorityQueue<String>> graph, List<String> result) {
        PriorityQueue<String> neighbors = graph.get(node);
        while (neighbors != null && !neighbors.isEmpty()) {
            String nextNode = neighbors.poll();
            dfs(nextNode, graph, result);
        }
        result.add(node);
    }
}
}