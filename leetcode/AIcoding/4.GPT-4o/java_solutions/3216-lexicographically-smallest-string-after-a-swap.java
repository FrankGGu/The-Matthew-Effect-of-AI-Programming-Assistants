import java.util.*;

class Solution {
    public String smallestStringWithSwaps(String s, List<List<Integer>> pairs) {
        int n = s.length();
        UnionFind uf = new UnionFind(n);

        for (List<Integer> pair : pairs) {
            uf.union(pair.get(0), pair.get(1));
        }

        Map<Integer, PriorityQueue<Character>> groups = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int root = uf.find(i);
            groups.putIfAbsent(root, new PriorityQueue<>());
            groups.get(root).offer(s.charAt(i));
        }

        StringBuilder result = new StringBuilder();
        for (int i = 0; i < n; i++) {
            int root = uf.find(i);
            result.append(groups.get(root).poll());
        }

        return result.toString();
    }
}

class UnionFind {
    private int[] parent;

    public UnionFind(int n) {
        parent = new int[n];
        for (int i = 0; i < n; i++) {
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