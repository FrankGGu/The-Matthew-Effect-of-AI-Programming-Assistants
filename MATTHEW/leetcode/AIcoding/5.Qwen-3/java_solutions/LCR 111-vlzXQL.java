public class Solution {

import java.util.*;

public class Solution {
    public double[] calcEquation(List<List<String>> equations, double[] values, List<List<String>> queries) {
        Map<String, Map<String, Double>> graph = new HashMap<>();

        for (int i = 0; i < equations.size(); i++) {
            String a = equations.get(i).get(0);
            String b = equations.get(i).get(1);
            double val = values[i];

            graph.putIfAbsent(a, new HashMap<>());
            graph.putIfAbsent(b, new HashMap<>());
            graph.get(a).put(b, val);
            graph.get(b).put(a, 1.0 / val);
        }

        double[] result = new double[queries.size()];

        for (int i = 0; i < queries.size(); i++) {
            String start = queries.get(i).get(0);
            String end = queries.get(i).get(1);
            if (!graph.containsKey(start) || !graph.containsKey(end)) {
                result[i] = -1.0;
                continue;
            }
            if (start.equals(end)) {
                result[i] = 1.0;
                continue;
            }
            Set<String> visited = new HashSet<>();
            result[i] = dfs(start, end, graph, visited, 1.0);
        }

        return result;
    }

    private double dfs(String node, String target, Map<String, Map<String, Double>> graph, Set<String> visited, double value) {
        if (node.equals(target)) {
            return value;
        }
        visited.add(node);
        for (Map.Entry<String, Double> entry : graph.get(node).entrySet()) {
            String neighbor = entry.getKey();
            double weight = entry.getValue();
            if (!visited.contains(neighbor)) {
                double res = dfs(neighbor, target, graph, visited, value * weight);
                if (res != -1.0) {
                    return res;
                }
            }
        }
        return -1.0;
    }
}
}