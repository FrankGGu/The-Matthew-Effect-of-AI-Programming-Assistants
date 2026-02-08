public class Solution {

import java.util.*;

public class Solution {
    public int numberOfGoodPaths(int[] vals, int[][] edges) {
        int n = vals.length;
        Map<Integer, List<Integer>> adj = new HashMap<>();
        for (int[] edge : edges) {
            adj.computeIfAbsent(edge[0], k -> new ArrayList<>()).add(edge[1]);
            adj.computeIfAbsent(edge[1], k -> new ArrayList<>()).add(edge[0]);
        }

        TreeMap<Integer, List<Integer>> valueToNodes = new TreeMap<>();
        for (int i = 0; i < n; i++) {
            valueToNodes.computeIfAbsent(vals[i], k -> new ArrayList<>()).add(i);
        }

        int[] parent = new int[n];
        Arrays.fill(parent, -1);

        int result = n;

        for (Map.Entry<Integer, List<Integer>> entry : valueToNodes.entrySet()) {
            int value = entry.getKey();
            List<Integer> nodes = entry.getValue();

            for (int node : nodes) {
                for (int neighbor : adj.get(node)) {
                    if (vals[neighbor] <= value) {
                        union(node, neighbor, parent);
                    }
                }
            }
        }

        return result;
    }

    private int find(int x, int[] parent) {
        if (parent[x] != x) {
            parent[x] = find(parent[x], parent);
        }
        return parent[x];
    }

    private void union(int x, int y, int[] parent) {
        int rootX = find(x, parent);
        int rootY = find(y, parent);

        if (rootX != rootY) {
            parent[rootY] = rootX;
        }
    }
}
}