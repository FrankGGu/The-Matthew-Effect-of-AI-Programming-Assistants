public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> lexicographicallySmallestArray(List<Integer> nums, int k) {
        int n = nums.size();
        List<Integer> result = new ArrayList<>(Collections.nCopies(n, 0));
        List<Integer> indices = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            indices.add(i);
        }
        Collections.sort(indices, (a, b) -> nums.get(a) - nums.get(b));
        int[] pos = new int[n];
        for (int i = 0; i < n; i++) {
            pos[indices.get(i)] = i;
        }
        int[] parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }
        int[] size = new int[n];
        Arrays.fill(size, 1);
        for (int i = 0; i < n; i++) {
            int idx = indices.get(i);
            int next = idx + 1;
            if (next < n && nums.get(next) == nums.get(idx)) {
                union(parent, size, idx, next);
            }
        }
        Map<Integer, List<Integer>> groups = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int root = find(parent, i);
            groups.putIfAbsent(root, new ArrayList<>());
            groups.get(root).add(i);
        }
        for (Map.Entry<Integer, List<Integer>> entry : groups.entrySet()) {
            List<Integer> group = entry.getValue();
            Collections.sort(group);
            Collections.sort(group, (a, b) -> nums.get(a) - nums.get(b));
            for (int i = 0; i < group.size(); i++) {
                result.set(group.get(i), nums.get(group.get(i)));
            }
        }
        return result;
    }

    private int find(int[] parent, int x) {
        if (parent[x] != x) {
            parent[x] = find(parent, parent[x]);
        }
        return parent[x];
    }

    private void union(int[] parent, int[] size, int x, int y) {
        int rootX = find(parent, x);
        int rootY = find(parent, y);
        if (rootX != rootY) {
            if (size[rootX] < size[rootY]) {
                parent[rootX] = rootY;
                size[rootY] += size[rootX];
            } else {
                parent[rootY] = rootX;
                size[rootX] += size[rootY];
            }
        }
    }
}
}