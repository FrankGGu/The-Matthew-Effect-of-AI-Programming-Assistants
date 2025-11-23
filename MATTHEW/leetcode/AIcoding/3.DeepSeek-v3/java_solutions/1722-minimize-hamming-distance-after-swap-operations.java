class Solution {
    private int[] parent;

    public int minimumHammingDistance(int[] source, int[] target, int[][] allowedSwaps) {
        int n = source.length;
        parent = new int[n];
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }

        for (int[] swap : allowedSwaps) {
            union(swap[0], swap[1]);
        }

        Map<Integer, Map<Integer, Integer>> groups = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int root = find(i);
            groups.putIfAbsent(root, new HashMap<>());
            Map<Integer, Integer> count = groups.get(root);
            count.put(source[i], count.getOrDefault(source[i], 0) + 1);
        }

        int res = 0;
        for (int i = 0; i < n; i++) {
            int root = find(i);
            Map<Integer, Integer> count = groups.get(root);
            if (count.getOrDefault(target[i], 0) == 0) {
                res++;
            } else {
                count.put(target[i], count.get(target[i]) - 1);
            }
        }

        return res;
    }

    private int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    private void union(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            parent[rootX] = rootY;
        }
    }
}