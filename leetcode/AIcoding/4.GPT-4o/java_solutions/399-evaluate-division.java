import java.util.*;

public class Solution {
    class Node {
        String value;
        double weight;

        Node(String value, double weight) {
            this.value = value;
            this.weight = weight;
        }
    }

    Map<String, List<Node>> graph = new HashMap<>();

    public double[] calcEquation(List<List<String>> equations, double[] values, List<List<String>> queries) {
        for (int i = 0; i < equations.size(); i++) {
            String a = equations.get(i).get(0);
            String b = equations.get(i).get(1);
            graph.putIfAbsent(a, new ArrayList<>());
            graph.putIfAbsent(b, new ArrayList<>());
            graph.get(a).add(new Node(b, values[i]));
            graph.get(b).add(new Node(a, 1.0 / values[i]));
        }

        double[] results = new double[queries.size()];
        for (int i = 0; i < queries.size(); i++) {
            results[i] = dfs(queries.get(i).get(0), queries.get(i).get(1), new HashSet<>(), 1.0);
        }

        return results;
    }

    private double dfs(String start, String end, Set<String> visited, double product) {
        if (!graph.containsKey(start) || !graph.containsKey(end)) return -1.0;
        if (start.equals(end)) return product;

        visited.add(start);

        for (Node neighbor : graph.get(start)) {
            if (!visited.contains(neighbor.value)) {
                double result = dfs(neighbor.value, end, visited, product * neighbor.weight);
                if (result != -1.0) return result;
            }
        }

        visited.remove(start);
        return -1.0;
    }
}