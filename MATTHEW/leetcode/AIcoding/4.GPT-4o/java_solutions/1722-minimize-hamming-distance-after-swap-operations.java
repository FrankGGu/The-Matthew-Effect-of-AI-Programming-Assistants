class Solution {
    public int minimumHammingDistance(int[] source, int[] target, int[][] allowedSwaps) {
        int n = source.length;
        UnionFind uf = new UnionFind(n);

        for (int[] swap : allowedSwaps) {
            uf.union(swap[0], swap[1]);
        }

        Map<Integer, Map<Integer, Integer>> countMap = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int root = uf.find(i);
            countMap.putIfAbsent(root, new HashMap<>());
            countMap.get(root).put(source[i], countMap.get(root).getOrDefault(source[i], 0) + 1);
        }

        int hammingDistance = 0;
        for (int i = 0; i < n; i++) {
            int root = uf.find(i);
            if (countMap.get(root).getOrDefault(target[i], 0) > 0) {
                countMap.get(root).put(target[i], countMap.get(root).get(target[i]) - 1);
            } else {
                hammingDistance++;
            }
        }

        return hammingDistance;
    }

    class UnionFind {
        int[] parent;

        UnionFind(int size) {
            parent = new int[size];
            for (int i = 0; i < size; i++) {
                parent[i] = i;
            }
        }

        int find(int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        void union(int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootX] = rootY;
            }
        }
    }
}