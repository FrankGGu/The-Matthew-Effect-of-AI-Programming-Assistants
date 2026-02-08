class Solution {
    public double[] calcEquation(List<List<String>> equations, double[] values, List<List<String>> queries) {
        Map<String, Map<String, Double>> graph = new HashMap<>();
        for (int i = 0; i < equations.size(); i++) {
            String u = equations.get(i).get(0);
            String v = equations.get(i).get(1);
            double value = values[i];
            graph.putIfAbsent(u, new HashMap<>());
            graph.putIfAbsent(v, new HashMap<>());
            graph.get(u).put(v, value);
            graph.get(v).put(u, 1.0 / value);
        }

        double[] res = new double[queries.size()];
        for (int i = 0; i < queries.size(); i++) {
            String start = queries.get(i).get(0);
            String end = queries.get(i).get(1);
            if (!graph.containsKey(start) || !graph.containsKey(end)) {
                res[i] = -1.0;
            } else {
                res[i] = dfs(graph, start, end, new HashSet<>());
            }
        }
        return res;
    }

    private double dfs(Map<String, Map<String, Double>> graph, String start, String end, Set<String> visited) {
        if (start.equals(end)) {
            return 1.0;
        }
        visited.add(start);
        for (Map.Entry<String, Double> entry : graph.get(start).entrySet()) {
            String next = entry.getKey();
            if (!visited.contains(next)) {
                double result = dfs(graph, next, end, visited);
                if (result != -1.0) {
                    return entry.getValue() * result;
                }
            }
        }
        return -1.0;
    }
}