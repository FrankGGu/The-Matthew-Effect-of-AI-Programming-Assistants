class Solution {
    public double[] calcEquation(List<List<String>> equations, double[] values, List<List<String>> queries) {
        Map<String, Map<String, Double>> graph = new HashMap<>();
        for (int i = 0; i < equations.size(); i++) {
            String u = equations.get(i).get(0);
            String v = equations.get(i).get(1);
            double val = values[i];
            graph.putIfAbsent(u, new HashMap<>());
            graph.get(u).put(v, val);
            graph.putIfAbsent(v, new HashMap<>());
            graph.get(v).put(u, 1.0 / val);
        }

        double[] res = new double[queries.size()];
        for (int i = 0; i < queries.size(); i++) {
            String start = queries.get(i).get(0);
            String end = queries.get(i).get(1);
            if (!graph.containsKey(start) || !graph.containsKey(end)) {
                res[i] = -1.0;
                continue;
            }
            res[i] = dfs(start, end, graph, new HashSet<>());
        }
        return res;
    }

    private double dfs(String node, String target, Map<String, Map<String, Double>> graph, Set<String> visited) {
        if (node.equals(target)) {
            return 1.0;
        }
        visited.add(node);
        for (Map.Entry<String, Double> entry : graph.get(node).entrySet()) {
            String neighbor = entry.getKey();
            if (visited.contains(neighbor)) {
                continue;
            }
            double res = dfs(neighbor, target, graph, visited);
            if (res != -1.0) {
                return res * entry.getValue();
            }
        }
        return -1.0;
    }
}