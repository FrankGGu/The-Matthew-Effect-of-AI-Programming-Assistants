class Solution {
    public double[] calcEquation(List<List<String>> equations, double[] values, List<List<String>> queries) {
        Map<String, Map<String, Double>> graph = new HashMap<>();

        for (int i = 0; i < equations.size(); i++) {
            String u = equations.get(i).get(0);
            String v = equations.get(i).get(1);
            double value = values[i];

            graph.putIfAbsent(u, new HashMap<>());
            graph.get(u).put(v, value);

            graph.putIfAbsent(v, new HashMap<>());
            graph.get(v).put(u, 1.0 / value);
        }

        double[] result = new double[queries.size()];
        for (int i = 0; i < queries.size(); i++) {
            String start = queries.get(i).get(0);
            String end = queries.get(i).get(1);

            if (!graph.containsKey(start) || !graph.containsKey(end)) {
                result[i] = -1.0;
                continue;
            }

            Set<String> visited = new HashSet<>();
            result[i] = dfs(graph, start, end, visited);
        }

        return result;
    }

    private double dfs(Map<String, Map<String, Double>> graph, String current, String target, Set<String> visited) {
        if (current.equals(target)) {
            return 1.0;
        }

        visited.add(current);

        for (Map.Entry<String, Double> neighbor : graph.get(current).entrySet()) {
            String next = neighbor.getKey();
            if (!visited.contains(next)) {
                double res = dfs(graph, next, target, visited);
                if (res != -1.0) {
                    return res * neighbor.getValue();
                }
            }
        }

        return -1.0;
    }
}