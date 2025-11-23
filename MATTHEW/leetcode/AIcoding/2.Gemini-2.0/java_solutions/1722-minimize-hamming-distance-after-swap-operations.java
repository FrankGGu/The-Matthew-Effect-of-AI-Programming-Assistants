import java.util.*;

class Solution {
    public int minimumHammingDistance(int[] source, int[] target, int[][] allowedSwaps) {
        int n = source.length;
        int[] parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }

        for (int[] swap : allowedSwaps) {
            int u = swap[0];
            int v = swap[1];
            int rootU = find(parent, u);
            int rootV = find(parent, v);
            if (rootU != rootV) {
                parent[rootU] = rootV;
            }
        }

        Map<Integer, List<Integer>> components = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int root = find(parent, i);
            components.computeIfAbsent(root, k -> new ArrayList<>()).add(i);
        }

        int hammingDistance = 0;
        for (List<Integer> component : components.values()) {
            Map<Integer, Integer> sourceCounts = new HashMap<>();
            Map<Integer, Integer> targetCounts = new HashMap<>();

            for (int index : component) {
                sourceCounts.put(source[index], sourceCounts.getOrDefault(source[index], 0) + 1);
                targetCounts.put(target[index], targetCounts.getOrDefault(target[index], 0) + 1);
            }

            for (Map.Entry<Integer, Integer> entry : sourceCounts.entrySet()) {
                int value = entry.getKey();
                int sourceCount = entry.getValue();
                int targetCount = targetCounts.getOrDefault(value, 0);
                hammingDistance += Math.max(0, sourceCount - targetCount);
            }
        }

        return hammingDistance;
    }

    private int find(int[] parent, int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent, parent[i]);
    }
}