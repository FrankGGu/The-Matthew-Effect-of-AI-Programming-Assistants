import java.util.Arrays;

class Solution {
    public int[] lexSmallestArray(int[] arr, int[][] swaps) {
        UnionFind uf = new UnionFind(arr.length);

        for (int[] swap : swaps) {
            uf.union(swap[0], swap[1]);
        }

        Map<Integer, List<Integer>> groups = new HashMap<>();

        for (int i = 0; i < arr.length; i++) {
            int root = uf.find(i);
            groups.putIfAbsent(root, new ArrayList<>());
            groups.get(root).add(arr[i]);
        }

        for (List<Integer> group : groups.values()) {
            Collections.sort(group);
        }

        int[] result = new int[arr.length];

        for (int i = 0; i < arr.length; i++) {
            int root = uf.find(i);
            result[i] = groups.get(root).remove(0);
        }

        return result;
    }
}

class UnionFind {
    private int[] parent;

    public UnionFind(int size) {
        parent = new int[size];
        for (int i = 0; i < size; i++) {
            parent[i] = i;
        }
    }

    public int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    public void union(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            parent[rootY] = rootX;
        }
    }
}