import java.util.*;

class Solution {
    public double[] calcEquation(List<List<String>> equations, double[] values, List<List<String>> queries) {
        Map<String, Map<String, Double>> graph = new HashMap<>();
        for (int i = 0; i < equations.size(); i++) {
            List<String> equation = equations.get(i);
            String dividend = equation.get(0);
            String divisor = equation.get(1);
            double value = values[i];

            graph.putIfAbsent(dividend, new HashMap<>());
            graph.putIfAbsent(divisor, new HashMap<>());

            graph.get(dividend).put(divisor, value);
            graph.get(divisor).put(dividend, 1.0 / value);
        }

        double[] results = new double[queries.size()];
        for (int i = 0; i < queries.size(); i++) {
            List<String> query = queries.get(i);
            String dividend = query.get(0);
            String divisor = query.get(1);

            if (!graph.containsKey(dividend) || !graph.containsKey(divisor)) {
                results[i] = -1.0;
            } else if (dividend.equals(divisor)) {
                results[i] = 1.0;
            } else {
                results[i] = dfs(dividend, divisor, graph, new HashSet<>());
            }
        }

        return results;
    }

    private double dfs(String dividend, String divisor, Map<String, Map<String, Double>> graph, Set<String> visited) {
        if (graph.get(dividend).containsKey(divisor)) {
            return graph.get(dividend).get(divisor);
        }

        visited.add(dividend);

        for (String neighbor : graph.get(dividend).keySet()) {
            if (!visited.contains(neighbor)) {
                double result = dfs(neighbor, divisor, graph, visited);
                if (result != -1.0) {
                    return graph.get(dividend).get(neighbor) * result;
                }
            }
        }

        return -1.0;
    }
}