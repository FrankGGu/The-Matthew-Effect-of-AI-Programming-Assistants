import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    private int[] parent;

    private void init(int n) {
        parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }
    }

    private int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        parent[i] = find(parent[i]);
        return parent[i];
    }

    private void union(int i, int j) {
        int rootI = find(i);
        int rootJ = find(j);
        if (rootI != rootJ) {
            parent[rootJ] = rootI;
        }
    }

    public int minimizeHammingDistance(int[] source, int[] target, List<List<Integer>> allowedSwaps) {
        int n = source.length;
        init(n);

        for (List<Integer> swap : allowedSwaps) {
            union(swap.get(0), swap.get(1));
        }

        Map<Integer, Map<Integer, Integer>> componentSourceCounts = new HashMap<>();
        Map<Integer, Map<Integer, Integer>> componentTargetCounts = new HashMap<>();

        for (int i = 0; i < n; i++) {
            int root = find(i);

            componentSourceCounts.computeIfAbsent(root, k -> new HashMap<>())
                                 .merge(source[i], 1, Integer::sum);

            componentTargetCounts.computeIfAbsent(root, k -> new HashMap<>())
                                 .merge(target[i], 1, Integer::sum);
        }

        int hammingDistance = 0;

        for (Map.Entry<Integer, Map<Integer, Integer>> entry : componentSourceCounts.entrySet()) {
            int root = entry.getKey();
            Map<Integer, Integer> sourceCounts = entry.getValue();
            Map<Integer, Integer> targetCounts = componentTargetCounts.get(root);

            for (Map.Entry<Integer, Integer> sourceEntry : sourceCounts.entrySet()) {
                int num = sourceEntry.getKey();
                int countS = sourceEntry.getValue();

                int countT = targetCounts.getOrDefault(num, 0);

                hammingDistance += Math.max(0, countS - countT);
            }
        }

        return hammingDistance;
    }
}