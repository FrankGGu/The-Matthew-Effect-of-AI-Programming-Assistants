import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Solution {
    class UnionFind {
        Map<String, String> parent = new HashMap<>();
        Map<String, Double> weight = new HashMap<>();

        public String find(String x) {
            if (!parent.containsKey(x)) {
                parent.put(x, x);
                weight.put(x, 1.0);
            }
            if (!x.equals(parent.get(x))) {
                String origin = parent.get(x);
                String root = find(origin);
                parent.put(x, root);
                weight.put(x, weight.get(x) * weight.get(origin));
            }
            return parent.get(x);
        }

        public void union(String x, String y, double value) {
            String rootX = find(x);
            String rootY = find(y);
            if (!rootX.equals(rootY)) {
                parent.put(rootY, rootX);
                weight.put(rootY, weight.get(x) / weight.get(y) * value);
            }
        }

        public double getWeight(String x, String y) {
            if (!parent.containsKey(x) || !parent.containsKey(y)) {
                return -1.0;
            }
            if (find(x).equals(find(y))) {
                return weight.get(y) / weight.get(x);
            }
            return -1.0;
        }
    }

    public double[] calcEquation(List<List<String>> equations, double[] values, List<List<String>> queries) {
        UnionFind uf = new UnionFind();
        for (int i = 0; i < equations.size(); i++) {
            uf.union(equations.get(i).get(0), equations.get(i).get(1), values[i]);
        }
        double[] result = new double[queries.size()];
        for (int i = 0; i < queries.size(); i++) {
            result[i] = uf.getWeight(queries.get(i).get(0), queries.get(i).get(1));
        }
        return result;
    }
}