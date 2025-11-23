import java.util.*;

class Solution {
    public double[] calcEquation(List<List<String>> equations, double[] values, List<List<String>> queries) {
        Map<String, Map<String, Double>> graph = new HashMap<>();

        // Build the graph
        for (int i = 0; i < equations.size(); i++) {
            String A = equations.get(i).get(0);
            String B = equations.get(i).get(1);
            double val = values[i];

            graph.computeIfAbsent(A, k -> new HashMap<>()).put(B, val);
            graph.computeIfAbsent(B, k -> new HashMap<>()).put(A, 1.0 / val);
        }

        double[] results = new double[queries.size()];
        for (int i = 0; i < queries.size(); i++) {
            String C = queries.get(i).get(0);
            String D = queries.get(i).get(1);

            if (!graph.containsKey(C) || !graph.containsKey(D)) {
                results[i] = -1.0;
            } else if (C.equals(D)) {
                results[i] = 1.0;
            } else {
                Set<String> visited = new HashSet<>();
                results[i] = dfs(C, D, graph, visited);
            }
        }

        return results;
    }

    private double dfs(String start, String end, Map<String, Map<String, Double>> graph, Set<String> visited) {
        visited.add(start);

        // Check if there's a direct edge from start to end
        if (graph.get(start).containsKey(end)) {
            return graph.get(start).get(end);
        }

        // Explore neighbors
        for (Map.Entry<String, Double> neighborEntry : graph.get(start).entrySet()) {
            String neighbor = neighborEntry.getKey();
            double value = neighborEntry.getValue();

            if (!visited.contains(neighbor)) {
                double result = dfs(neighbor, end, graph, visited);
                if (result != -1.0) {
                    // If a path is found from neighbor to end, then start/end = (start/neighbor) * (neighbor/end)
                    return value * result;
                }
            }
        }

        // No path found from start to end
        return -1.0;
    }
}