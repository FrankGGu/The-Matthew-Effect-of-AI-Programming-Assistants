import java.util.*;

class Solution {
    private Map<String, String> parent;
    private Map<String, Double> values; // stores var / parent[var]

    public double[] calcEquation(List<List<String>> equations, double[] values, List<List<String>> queries) {
        this.parent = new HashMap<>();
        this.values = new HashMap<>();

        for (int i = 0; i < equations.size(); i++) {
            String var1 = equations.get(i).get(0);
            String var2 = equations.get(i).get(1);
            double val = values[i];
            union(var1, var2, val);
        }

        double[] results = new double[queries.size()];
        for (int i = 0; i < queries.size(); i++) {
            String var1 = queries.get(i).get(0);
            String var2 = queries.get(i).get(1);

            if (!parent.containsKey(var1) || !parent.containsKey(var2)) {
                results[i] = -1.0;
            } else {
                String root1 = find(var1);
                String root2 = find(var2);

                if (!root1.equals(root2)) {
                    results[i] = -1.0;
                } else {
                    results[i] = this.values.get(var1) / this.values.get(var2);
                }
            }
        }
        return results;
    }

    private String find(String var) {
        if (!parent.containsKey(var)) {
            parent.put(var, var);
            values.put(var, 1.0);
            return var;
        }

        if (parent.get(var).equals(var)) {
            return var;
        }

        String root = find(parent.get(var));
        values.put(var, values.get(var) * values.get(parent.get(var)));
        parent.put(var, root);
        return root;
    }

    private void union(String var1, String var2, double val) {
        String root1 = find(var1);
        String root2 = find(var2);

        if (!root1.equals(root2)) {
            parent.put(root1, root2);
            // We want to set values.get(root1) to root1 / root2
            // We know:
            // var1 / root1 = values.get(var1)  => root1 = var1 / values.get(var1)
            // var2 / root2 = values.get(var2)  => root2 = var2 / values.get(var2)
            // var1 / var2 = val (given)
            // So, root1 / root2 = (var1 / values.get(var1)) / (var2 / values.get(var2))
            //                  = (var1 / var2) * (values.get(var2) / values.get(var1))
            //                  = val * (values.get(var2) / values.get(var1))
            values.put(root1, val * (values.get(var2) / values.get(var1)));
        }
    }
}