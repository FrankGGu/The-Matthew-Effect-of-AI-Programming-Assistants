import java.util.*;

class Solution {
    private int[] parent;
    private int[] size;

    private void init(int n) {
        parent = new int[n];
        size = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
            size[i] = 1;
        }
    }

    private int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    private void union(int i, int j) {
        int rootI = find(i);
        int rootJ = find(j);
        if (rootI != rootJ) {
            if (size[rootI] < size[rootJ]) {
                parent[rootI] = rootJ;
                size[rootJ] += size[rootI];
            } else {
                parent[rootJ] = rootI;
                size[rootI] += size[rootJ];
            }
        }
    }

    private static class Element {
        int value;
        int originalIndex;

        Element(int value, int originalIndex) {
            this.value = value;
            this.originalIndex = originalIndex;
        }
    }

    public int[] lexicographicallySmallestArray(int[] nums, int limit) {
        int n = nums.length;

        Element[] elements = new Element[n];
        for (int i = 0; i < n; i++) {
            elements[i] = new Element(nums[i], i);
        }

        Arrays.sort(elements, (a, b) -> a.value - b.value);

        init(n);

        for (int i = 1; i < n; i++) {
            if (elements[i].value - elements[i-1].value <= limit) {
                union(elements[i].originalIndex, elements[i-1].originalIndex);
            }
        }

        Map<Integer, List<Integer>> componentValues = new HashMap<>();
        Map<Integer, List<Integer>> componentIndices = new HashMap<>();

        for (int i = 0; i < n; i++) {
            int root = find(i);
            componentValues.computeIfAbsent(root, k -> new ArrayList<>()).add(nums[i]);
            componentIndices.computeIfAbsent(root, k -> new ArrayList<>()).add(i);
        }

        int[] result = new int[n];
        for (int root : componentValues.keySet()) {
            List<Integer> values = componentValues.get(root);
            List<Integer> indices = componentIndices.get(root);

            Collections.sort(values);
            Collections.sort(indices);

            for (int i = 0; i < values.size(); i++) {
                result[indices.get(i)] = values.get(i);
            }
        }

        return result;
    }
}